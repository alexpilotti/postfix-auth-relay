#!/bin/bash
set -e
service saslauthd start
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf
postfix start-fg
