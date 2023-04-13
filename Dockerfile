FROM v2fly/v2fly-core

ENV TZ=Asia/Shanghai

COPY config.json /etc/v2ray/

COPY Caddyfile /etc/caddy/Caddyfile

# azure Start and enable SSH
COPY sshd_config /etc/ssh/
RUN apk add openssh \
    && echo "root:Docker!" | chpasswd \
    && cd /etc/ssh/ \
    && ssh-keygen -A

COPY entrypoint.sh ./

RUN chmod +x ./entrypoint.sh

EXPOSE 10000 2222

ENTRYPOINT [ "./entrypoint.sh" ]