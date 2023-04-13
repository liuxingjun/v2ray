#!/bin/sh
set -e
/usr/sbin/sshd
exec /usr/bin/v2ray run -c /etc/v2ray/config.json