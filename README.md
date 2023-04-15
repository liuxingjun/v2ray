# v2ray

## run 
```
docker run -d --name v2ray liuxingjun/v2ray
```
### caddy

```
docker run -d -e CADDY_DEBUG=debug -e WEBSITE_HOSTNAME=mydomain.com -v ~/.caddy:/data/caddy --name v2ray liuxingjun/v2ray:caddy
```

## test 
```
curl --socks5 127.0.0.1:1080 -I https://www.google.com
```
## build 

```
docker build -t liuxingjun/v2ray .
```