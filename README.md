## 🔥🐳 Dockerfile/Containerfile and S2I Demo

Examples in the preceding directories are described below:

### Based on Dockerfile or Containerfile

- 🌈 **apache-rhce8.2-course-1.0**: RHCEv8.2 course environment based Apache HTTPD
- 🏔 **apache-rhce8.2-course-alpine**: RHCEv8.2 course environment based Apache HTTPD on `Alpine 3.14.2`
- 🐱‍🏍 **nginx-ssl**: customized `Nginx v1.22.1` with CA signed certification
- 📜 **loganalyzer-viewer**: loganalyzer `php` application based Apache HTTPD 
- 🦄 **code-server-4.8.3**: `Golang v1.19.3` IDE used as VS Code based Code Server v4.8.3 with Web UI
- 🧪 *jekyll-blog*: jekyll use `GitHub Page` to build blog with suffix `github.io`
- 🥽 **ONBUILD-example/apache-httpd-app**: `ONBUILD` directive through httpd-parent and httpd-child container image 
- 💪 **tl500-mono-repo**: `JavaScript` application in Node.js apply `TL500` tech exercises instruction
- 📦 **nexus-3.30.1-01**: `Nexus3` artifacts repository image used by [Nexus3 Chart](https://github.com/Alberthua-Perl/go-kubernetes-learn-path/tree/hotfixes/helm3-dev/nexus-3.30.1-01)
- 🧱 **node-pnpm**: Node.js 18 and pnpm 10.11.0 runtime as base image
- ✒  **etherpad-lite-build**: etherpad-lite application in Node.js runtime which connect with postgres server through settings.json. The postgres server should be deployed before this application. Or remove settings.json, run this application directly. etherpad-lite-postgres cloned from [etherpad-lite](https://github.com/ether/etherpad-lite) project *master* branch.
  - But in this image including two config file to associate with local Nexus3 registry (.npmrc) and local postgresql-server (settings.json), so we should change some settings.
  - `.npmrc` as followings:

  ```plaintext
  registry=http://nexus3.lab.example.com:8881/repository/npm-proxy/
  always-auth=true
  //nexus3.lab.example.com:8881/repository/npm-proxy/:_auth="ZGV2dXNlcjA6MXFhelpTRSQ="
  //nexus3.lab.example.com:8881/repository/npm-hosted/:_auth="ZGV2dXNlcjA6MXFhelpTRSQ="
  ```

  - `settings.json` as followings:

  ```json
  {
      "dbType": "postgres",
      "dbSettings": {
        "user": "etherpad_user",
        "host": "serverd.lab.example.com",
        "port": 5432,
        "password": "redhat",
        "database": "etherpad_db"
      },
      "ip": "0.0.0.0",
      "port": 9001,
      "title": "Etherpad"
  }
  ```

- 🌶 **tf-flask**: runtime including tensorflow, keras, numpy, matplotlib, flask and so on. This image is used as base image to run CNN module by flask inference frame.

### Based on S2I

- ⭕ **golang-s2i**: Dockerfile to build `Golang v1.12` s2i-builder image in which insert code to generate application image

### Based on docker-compose or podman-compose

- 📥 **gogs-postgres-compose**: Source Control Management (`SCM`) application based `Gogs` and `PostgreSQL` deployed by `podman-compose`
- 🐘 **pgadmin-pgdb-compose**: Postgre admin Web site used to connect with PostgreSQL database via podman-compose
