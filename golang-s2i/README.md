## 基于 S2I 的 Golang 应用构建与部署示例
[![Docker Repository on Quay](https://quay.io/repository/clcollins/golang-builder/status "Docker Repository on Quay")](https://quay.io/repository/clcollins/golang-builder)

##### 文档说明：

1. OS 版本：Red Hat Enterprise Linux Server release 7.5 (Maipo)
2. OCP 版本：Red Hat OpenShift Container Platform 3.9.14
3. GitWeb 版本：gitweb-1.8.3.1-13.el7.noarch
4. S2I 版本：source-to-image-v1.3.1-a5a77147-linux-amd64
5. 关于 S2I 的中文文档较少，且相关文档中的构建步骤与说明不详细，因此该文档以 Golang 应用为例说明 S2I 单独构建应用镜像的过程，以及集成至 OpenShift 中的应用构建与部署。

##### 文档目录：

- S2I 基本原理
- 创建 Golang 构建镜像
- 创建 Golang 应用镜像
- OpenShift 集成构建 Golang 应用

#### S2I 基本原理：

1. 源代码构建（source to image, S2I）是 OpenShift 常用的一种构建策略，也是 Red Hat 提供的镜像构建开源工具。

2. S2I 将基础镜像与应用代码利用一套约定的规则与构建流程，最终构建出用户需要的应用镜像。

3. 在 S2I 构建中，当源代码变动时，用户无须使用 docker build 命令来构建镜像，而是由 S2I 工具自动执行代码变更后的构建过程。

4. 因此，使用 S2I 工具可以得到与源代码实时保持一致的应用镜像，让应用镜像的构建变的更加方便和简单。

5. S2I 的构建过程包含 3 个基本元素，即应用代码、构建镜像（`builder image`）和 S2I 脚本。

6. 其中 S2I 脚本主要包含构建脚本（`assemble`）和运行脚本（`run`）。

7. S2I 脚本存放的默认目录，如下所示：

   ![](D:\Linux操作系统与编程语言汇总\Typora文档汇总\OpenShift\pictures\基于S2I的Golang应用构建与部署示例\s2i-scripts.jpg)

   1）以上标记的相关文件与脚本是 S2I 构建过程中必须存在的。

   2）**`Dockerfile`**：用于定义如何创建构建镜像

   3）**`s2i/bin/assemble`**：用于指导源代码如何通过构建镜像进行编译构建，其中包含编译运行环境或框架等。

   4）**`s2i/bin/run`**：用于源代码构建后运行应用

   5）test/test-app：用于测试应用源代码

8. S2I 构建应用镜像的流程：

   1）基础镜像（base image）--> Dockerfile --> 构建镜像（包含 S2I 脚本）
   
   2）应用源代码 --> s2i command & 构建镜像 --> 应用镜像
   
   ![](D:\Linux操作系统与编程语言汇总\Typora文档汇总\OpenShift\pictures\基于S2I的Golang应用构建与部署示例\S2I-Developer-WorkFlow.jpg)

#### 创建 Golang 构建镜像：

1. 使用 `golang:1.12` 基础镜像创建构建镜像，作为 Golang 应用的构建环境。

2. 可通过如下命令生成 Dockerfile 与 S2I 脚本模板，均存储于 `golang-s2i` 目录中，该目录无需提前创建。

   ```bash
   $ s2i create golang-builder $HOME/golang-s2i
   ```

   ```
   $ tree $HOME/golang-s2i
     $HOME/golang-s2i
     ├── Dockerfile
     ├── Makefile
     ├── README.md
     ├── s2i
     │   └── bin
     │       ├── assemble
     │       ├── run
     │       ├── save-artifacts
     │       └── usage
     └── test
         ├── run
         └── test-app
             └── index.html
   
     4 directories, 9 files
   ```

3. 更改原始 Dockerfile 模板用于创建构建镜像，如下所示：

   ```dockerfile
   # repository cloned from https://github.com/clcollins/golang-s2i.git
   # golang-builder
   FROM golang:1.12
   LABEL maintainer "Longfei Hua <hualongfeiyyy@163.com>"
   
   # environment variable GOCACHE=/tmp seted to avoid write errors when
   # running the build as a user other than root
   # 
   # environment variable SOURCE_DIR=/go/src/app depends on base image
   # GOPATH=/go environment variable in golang:1.12 base image 
   ENV CGO_ENABLED=0 \
       GOOS=linux \
       GOCACHE=/tmp \
       STI_SCRIPTS_PATH=/usr/libexec/s2i \
       SOURCE_DIR=/go/src/app
   
   LABEL io.k8s.description="Builder image for compiling and testing Go applications" \
         io.k8s.display-name="golang-builder" \
         io.openshift.s2i.scripts-url=image://${STI_SCRIPTS_PATH}
         
   # Copy the s2i scripts into the golang image
   # These scripts describe how to build & run the application, and extract artifacts 
   # for downstream builds
   COPY ./s2i/bin/ ${STI_SCRIPTS_PATH}
   
   # The $SOURCE_DIR is dependent on the upstream golang image, based on the 
   # $GOPATH, etc. variable set there
   #
   # Allow random UIDs to write to the $SOURCE_DIR (for OKD/OpenShift)
   RUN mkdir -p $SOURCE_DIR && \
       chmod 0777 $SOURCE_DIR
   
   WORKDIR $SOURCE_DIR
   
   # Drop root (as is tradition)
   USER 1001
   
   # usage script just print regular messages
   CMD ["/usr/libexec/s2i/usage"]
   ```

4. 更改原始 s2i/bin/assemble 脚本用于创建构建镜像，而 s2i/bin/run 等脚本不再赘述，可参考链接中的相关文档。

   ```bash
   #!/bin/bash -e
   #
   # S2I assemble script for the 'golang-builder' image.
   # The 'assemble' script builds your application source so that it is ready to run.
   #
   # For more information refer to the documentation:
   #	https://github.com/openshift/source-to-image/blob/master/docs/builder_image.md
   #
   
   set -o errexit
   
   # If the 'golang-builder' assemble script is executed with the '-h' flag, print the usage.
   if [[ "$1" == "-h" ]]; then
   	exec /usr/libexec/s2i/usage
   fi
   
   # Restore artifacts from the previous build (if they exist).
   #
   # assemble script builded in 'goland-builder' image, and run by s2i command call.
   # current directory is workdir $SOURCE_DIR(/go/src/app).
   if [ "$(ls /tmp/artifacts/ 2>/dev/null)" ]; then
     echo "---> Restoring build artifacts..."
     mv /tmp/artifacts/. ./
   fi
   
   # s2i copy application source into image /tmp/src/ directory.
   # And then copy application source to golang $SOURCE_DIR(/go/src/app).
   echo "---> Installing application source..."
   cp -Rf /tmp/src/. ./
   
   echo "---> Downloading dependencies..."
   go get -v
   
   # The -o app is important, as we have set this in the 
   # s2i/bin/run script, allowing it to run whatever app was
   # generated by the build below
   echo "---> Building application from source..."
   go build -v -o app -a -installsuffix cgo
   # app is the name of golang application which is in run script.
   
   #echo "---> Running tests..."
   #go test -v -o app_test.go
   ```

5. docker build 命令创建 Golang 构建镜像：

   ```bash
   $ sudo docker build -t goland-builder:v1.0 $HOME/golang-s2i
   ```

   > ✅注意✅：
   >
   > Dockerfile 定义如何创建构建镜像，封装 S2I 脚本而不触发其执行，只有使用 s2i 命令创建应用镜像时才调用脚本进行源代码编译与构建。

6. 创建的构建镜像应符合以下几个标准，使其满足通用的编译构建环境：

   1）通用原则：

      构建镜像一般应包含常见的应用编译工具，以及默认的构建与运行脚本。

      构建镜像并非只针对于具体某个项目，而是面向某种类型的项目，如针对 Python 类应用的构建镜像。

      这样才可以规范应用构建的流程，减少项目中构建流程的管理工作。

   2）简洁原则：

      构建过程中不要引入无关的文件，构建完成后要及时清除构建过程中生成的临时文件及应用源代码。

   3）安全原则：

      避免使用 root 用户，同时不要过度放开文件的权限。

#### 创建 Golang 应用镜像：

1. 该示例将部署基于 Golang 的 Web server，源代码位于：

   https://github.com/Alberthua-Perl/gopl.io/blob/main/goSimpleWebServer.go

2. 使用 s2i 命令创建应用镜像：

   s2i 命令将触发构建镜像中的 S2I assemble 与 run 脚本编译应用程序。
   
   ```bash
   $ s2i build $HOME/backup/gopl.io golang-builder:v1.0 go-web-server:v1.0
   ---> Installing application source...
   ---> Downloading dependencies...
   net
   net/textproto
   crypto/x509
   ...
   app
   ---> Building application from source...
   errors
   internal/cpu
   math/bits
   runtime/internal/atomic
   ...
   app
   Build completed successfully
   ```

3. 运行构建的容器化 Golang 应用：

   ```bash
   $ sudo docker run -d --rm --name=go-web-server -p 9090:9090 go-web-server:v1.0
   ```

#### OpenShift 集成构建 Golang 应用：

1. 此处使用的 OCP 3.9 集群中已集成 docker-distribution 容器镜像仓库以及基于 Web 的 GitWeb 代码仓库。

   > 💥注意💥：容器镜像仓库与代码仓库均运行于 registry.lab.example.com 节点上

2. 以上的两个组件均可直接推送或拉取镜像，以及匿名管理代码仓库，因此在使用 OCP `BuildConfig` 资源时无需创建 `secret` 资源对象，若使用 Quay、Harbor、GitHub、GitLab 等容器镜像仓库与代码仓库时，需配置所使用的用户名与密码以登录相应的仓库，否则应用构建（build）过程将失败。

3. 上传应用源码至 GitWeb 的相应代码 repository 中：

   ```bash
   $ scp -r $HOME/gopl.io/.git/* root@registry:/var/www/git/gopl.io/
   # GitWeb 仓库中的源代码只存储 .git 目录中的文件与目录
   ```

4. 推送构建镜像至容器镜像仓库中，并在 OCP OpenShift 项目中创建 ImageStream 资源对象：

   ```bash
   $ sudo docker tag golang-builder:v1.0 registry.lab.example.com/golang-builder:v1.0
   $ sudo docker push registry.lab.example.com/golang-builder:v1.0
   $ oc login -u admin -p redhat https://master.lab.example.com
   $ oc import-image golang-builder:v1.0 \
     --confirm --from registry.lab.example.com/golang-builder:v1.0 \
     -n openshift
   # 必须使用 OCP admin 集群管理员用户创建 ImageStream
   ```

5. 使用 oc new-app 命令创建 BuildConfig、ImageStream 与 DeploymentConfig 资源对象：

   ```bash
   $ oc new-app \
     --name=go-web-server \
     golang-builder:v1.0~http://services.lab.example.com/gopl.io
     --> Found image 22c67f5 (9 hours old) in image stream "openshift/golang-builder" under tag 
         "v1.0" for "golang-builder:v1.0"
   
         golang-builder 
         -------------- 
         Builder image for compiling and testing Go applications
   
         * A source build using source code from http://services.lab.example.com/gopl.io will 
           be created
           * The resulting image will be pushed to image stream "go-web-server:latest"
           * Use 'start-build' to trigger a new build
         * This image will be deployed in deployment config "go-web-server"
         * The image does not expose any ports - if you want to load balance or send traffic to 
           this component
           you will need to create a service with 'expose dc/go-web-server --port=[port]' later
   
     --> Creating resources ...
         imagestream "go-web-server" created
         buildconfig "go-web-server" created
         deploymentconfig "go-web-server" created
     --> Success
         Build scheduled, use 'oc logs -f bc/go-web-server' to track its progress.
         Run 'oc status' to view your app.
         
   ```

6. 定义应用的 Service 资源对象：

   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     annotations:
       openshift.io/generated-by: OpenShiftNewApp
     labels:
       app: go-web-server
     name: go-web-server
     namespace: golang-s2i-app
   spec:
     ports:
     - name: 9090-tcp
       port: 9090
       protocol: TCP
       targetPort: 9090
     selector:
       app: go-web-server
       deploymentconfig: go-web-server
     sessionAffinity: None
     type: ClusterIP
   status:
     loadBalancer: {}
   ```

   ```bash
   $ oc apply -f go-web-server-svc.yml
   $ oc expose svc go-web-server --hostname=go-web-server.apps.lab.example.com
   # 创建 route 资源对象，使应用可被外部访问。
   ```

7. 测试应用的可用性，如下所示：

   ```bash
   $ curl http://go-web-server.apps.lab.example.com
     Test S2I process!
   ```

#### 参考链接：

- Source-To-Image (S2I)：

  https://github.com/openshift/source-to-image

- Writing your own Golang Builder with Source-to-Image：

  https://github.com/clcollins/golang-s2i

- Creating a basic S2I builder image：

  https://github.com/openshift/source-to-image/tree/master/examples/nginx-centos7#creating-a-basic-s2i-builder-image
