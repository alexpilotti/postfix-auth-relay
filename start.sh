#!/bin/bash
set -e
service saslauthd start
mkdir -p /var/spool/postfix/etc
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf
postfix start-fg
