# v2ray

## run 
```
docker run -d -e WEBSITE_HOSTNAME=mydomain.com --name v2ray liuxingjun/v2ray
```
## test 
```
curl --socks5 127.0.0.1:1080 -I https://www.google.com
```
## build 

```
docker build -t liuxingjun/v2ray .
```