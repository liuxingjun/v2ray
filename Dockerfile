FROM v2fly/v2fly-core as v2ray
ENV TZ=Asia/Shanghai
COPY v2ray /etc/v2ray
RUN rm /var/log/v2ray/*
COPY --chmod=555 entrypoint.sh entrypoint.sh
EXPOSE 10000
ENTRYPOINT [ "/root/entrypoint.sh" ]

FROM v2ray as nginx
RUN apk add nginx
COPY default.conf /etc/nginx/http.d/
RUN sed -i '$i\nginx -g "daemon on;"' /root/entrypoint.sh

EXPOSE 80

FROM v2ray as caddy
COPY Caddyfile /etc/caddy/Caddyfile
RUN apk add caddy
COPY default.conf /etc/nginx/http.d/
RUN sed -i '$i\caddy start --config /etc/caddy/Caddyfile' /root/entrypoint.sh
EXPOSE 80 443

FROM nginx as azure
# ssh
COPY sshd_config /etc/ssh/
RUN apk add openssh \
    && cd /etc/ssh/ \
    && ssh-keygen -A 
RUN sed -i '$i\/usr/sbin/sshd' /root/entrypoint.sh
# azure ssh
RUN echo "root:Docker!" | chpasswd