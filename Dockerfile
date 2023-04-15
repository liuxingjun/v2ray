FROM v2fly/v2fly-core

ENV TZ=Asia/Shanghai

# v2ray
COPY v2ray /etc/v2ray
RUN rm /var/log/v2ray/*

# entrypoint
RUN echo -e '#!/bin/sh\nset -e' >> /root/entrypoint.sh \
    && chmod +x /root/entrypoint.sh

# caddy
COPY Caddyfile /etc/caddy/Caddyfile
RUN apk add caddy
ARG caddy
RUN if [ -n "$caddy" ]; then \
    echo 'caddy start --config /etc/caddy/Caddyfile' >> /root/entrypoint.sh
    fi
# RUN 



# nginx
RUN apk add nginx
COPY default.conf /etc/nginx/http.d/
ARG nginx
RUN if [ -n "$nginx" ]; then \
    echo 'nginx -g "daemon off;"' >> /root/entrypoint.sh
    fi

# ssh
COPY sshd_config /etc/ssh/
RUN apk add openssh \
    && cd /etc/ssh/ \
    && ssh-keygen -A \
    && echo '/usr/sbin/sshd' >> /root/entrypoint.sh

# azure Start and enable SSH
ARG azure_ssh
RUN if [ -n "$azure_ssh" ]; then \
    echo "root:Docker!" | chpasswd 
    fi

RUN apk add curl

EXPOSE 80 443 2222

RUN echo 'exec /usr/bin/v2ray run -c /etc/v2ray/config.json' >> /root/entrypoint.sh
ENTRYPOINT [ "/root/entrypoint.sh" ]