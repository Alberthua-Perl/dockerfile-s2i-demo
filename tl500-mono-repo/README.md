## TL500 Mono Repo Container Image

- 应用说明：

  该容器镜像使用 `NodeJS` 应用提供 `TL500` 课程的技术练习指导手册。

- 构建镜像与运行容器：

  ```bash
  $ sudo docker build -t tl500-mono-repo:v1.0 .
  # 当前目录上下文中构建容器镜像
  $ sudo docker run -d --name=tl500-mono-repo -p 3000:3000 tl500-mono-repo:v1.0
  # 使用容器端口映射运行容器
  ```

- 访问应用：

  使用浏览器以 `http://<host_ip>:3000` 作为访问地址以访问应用，其中 `host_ip` 为容器宿主机 IP 地址。