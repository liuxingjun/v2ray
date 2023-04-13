FROM v2fly/v2fly-core

ENV TZ=Asia/Shanghai

# v2ray
COPY config.json /etc/v2ray/
RUN rm /var/log/v2ray/*

# entrypoint
RUN echo -e '#!/bin/sh\nset -e' >> /root/entrypoint.sh \
    && chmod +x /root/entrypoint.sh

# caddy
COPY Caddyfile /etc/caddy/Caddyfile
RUN apk add caddy
RUN echo 'caddy start --config /etc/caddy/Caddyfile' >> /root/entrypoint.sh

# azure Start and enable SSH
COPY sshd_config /etc/ssh/
RUN apk add openssh \
    && echo "root:Docker!" | chpasswd \
    && cd /etc/ssh/ \
    && ssh-keygen -A \
    && echo '/usr/sbin/sshd' >> /root/entrypoint.sh

EXPOSE 10000 2222

RUN echo 'exec /usr/bin/v2ray run -c /etc/v2ray/config.json' >> /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]