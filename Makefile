# 帮助信息
.PHONY: all azure caddy nginx help

help:
	@echo "Available targets:"
	@echo "  help        Display this help message"
	@echo "  all         Build the project"
	@echo "  azure       单纯启动v2ray + azure ssh config"
	@echo "  caddy       v2ray + caddy 自签名证书"
	@echo "  nginx       v2ray + nginx 无证书"

all: azure caddy nginx

# 构建 by azure 
azure: 
	docker build --build-arg ssh_azure=true -t liuxingjun/v2ray:azure .

# by caddy
caddy:
	docker build --build-arg caddy=true -t liuxingjun/v2ray:caddy .

nginx:
	docker build --build-arg nginx=true -t liuxingjun/v2ray:nginx .