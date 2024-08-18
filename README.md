## postfix-auth-relay

The purpose of this repository is to provide a Dockerfile and related
resources to easily deploy a Postfix service with SMTP authentication and
TLS encryption with a certificate optionally provided by
[Let's Encrypt](https://letsencrypt.org/).

Note: this requires a DNS entry matching your IP and, for your Postfix SMTP
service to be trusted by the next hop, a matching reverse DNS PTR record.

Build the docker image:

```console
docker build . -t postfix-auth-relay
```

Replace _"smtp_host_fqdn"_ in _main.cf_, _nginx/default.conf_,
_docker_certbot_init.sh_ and _docker_certbot_renew.sh_.
Set also your email in _docker_certbot_init.sh_.

Start the containers:

```console
mkdir -p certbot/conf
mkdir -p certbot/www
mkdir -p spool
touch sasldb2

docker compose up -d
```

Get a Let's Encrypt certificate with Certbot:

```console
./docker_certbot_init.sh
```

Reload Postfix:

```console
docker exec -ti docker-postfix-postfix-1 postfix reload
```

Create a new user for your SMTP service. This has to be an email address
user@domain (e.g. usern1@example.com)

```console
docker exec -ti docker-postfix-postfix-1 saslpasswd2 -c -u domain user
```

To list the users already defined:

```console
docker exec -ti docker-postfix-postfix-1 sasldblistusers2
```

A simple Python script to test your SMTP service by sending an email
is included:

```console
python3 smtp_auth_test.py \
--host smtp_host_fqdn \
--port port \
--username user@domain \
--password password \
--recipient user@domain
```

Optionally you can also add _--no-login_ or _--no-tls_ to verify if
the SMTP service's authentication and TLS settings are properly configured.

Check the docker logs for any issues:

```console
docker logs docker-postfix-postfix-1
```

Let's Encrypt certificates have a limited viability, so you migh want to
automate the renewal process with e.g. crontab:

```console
0 6 * * 1 /path/to/docker_certbot_renew.sh
```
