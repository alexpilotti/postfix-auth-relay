#!/bin/bash
set -e

docker run --rm --name certbot \
-v $(pwd)/certbot/conf:/etc/letsencrypt \
-v $(pwd)/certbot/www:/var/www/certbot \
certbot/certbot \
renew

docker exec -ti docker-postfix-postfix-1 postfix reload
