FROM v2fly/v2fly-core

ENV TZ=Asia/Shanghai

# v2ray
COPY config.json /etc/v2ray/
RUN rm /var/log/v2ray/*

# entrypoint
RUN echo -e '#!/bin/sh\nset -e' >> entrypoint.sh \
    && chmod +x entrypoint.sh

# caddy
COPY Caddyfile /etc/caddy/Caddyfile
RUN apk add caddy
RUN echo 'caddy run -c /etc/caddy/Caddyfile' >> entrypoint.sh

# azure Start and enable SSH
COPY sshd_config /etc/ssh/
RUN apk add openssh \
    && echo "root:Docker!" | chpasswd \
    && cd /etc/ssh/ \
    && ssh-keygen -A \
    && echo '/usr/sbin/sshd' >> entrypoint.sh

RUN echo 'exec /usr/bin/v2ray run -c /etc/v2ray/config.json' >> entrypoint.sh
EXPOSE 10000 2222

ENTRYPOINT [ "./entrypoint.sh" ]