## TL500 Mono Repo Container Image

[![Docker Repository on Quay](https://quay.io/repository/alberthua/tl500-mono-repo/status "Docker Repository on Quay")](https://quay.io/repository/alberthua/tl500-mono-repo)

- 应用说明：

  该容器镜像基于 `NodeJS` 构建 `JavaScript` 应用提供 `TL500` 课程的技术练习指导手册。

- 应用使用的 2 种方式（任选其一）：

  - 1️⃣ 应用构建与运行：

    ```bash
    $ sudo docker build -t tl500-mono-repo:v1.0 .
    # 当前目录上下文中构建容器镜像
    $ sudo docker run -d --name=tl500-mono-repo -p <host_port>:3000 tl500-mono-repo:v1.0
    # 使用容器端口映射运行容器
    ```

  > 💥 注意：`host_port` 为容器宿主机的端口，可根据实际情况加以指定。

  - 2️⃣ 直接运行应用：

    ```bash
    $ sudo docker run -d --name=tl500-mono-repo -p <host_port>:3000 quay.io/alberthua/tl500-mono-repo:v1.0
    # 直接拉取 quay.io 镜像运行应用
    ```    

- 访问应用：

  使用浏览器以 `http://<host_ip>:3000` 作为访问地址以访问应用，其中 `host_ip` 为容器宿主机 IP 地址。
  