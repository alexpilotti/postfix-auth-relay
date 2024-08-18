#!/bin/bash
docker run -ti --rm --name certbot \
-v $(pwd)/certbot/conf:/etc/letsencrypt \
-v $(pwd)/certbot/www:/var/www/certbot \
certbot/certbot certonly \
--agree-tos --webroot -w /var/www/certbot \
-m "your@email.com" \
-n \
--expand \
-d smtp.fqdn.com
