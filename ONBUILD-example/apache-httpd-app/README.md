## How to build apache-httpd-app contianer images?

- Step 1: 

  ```bash
  $ git clone https://github.com/Alberthua-Perl/dockerfile-s2i-demo.git
  $ cd dockerfile-s2i-demo/ONBUILD-example/apache-httpd-app/httpd-parent
  $ podman build -t httpd-parent:v1.0 .
  # wait several minutes to build httpd-parent container image in local podman cache
  ```

- Step 2:

  ```bash
  $ cd dockerfile-s2i-demo/ONBUILD-example/apache-httpd-app/httpd-child
  $ podman build -t httpd-child:v1.0 .
    Sending build context to Docker daemon 4.608 kB
    Step 1/6 : FROM httpd-parent:v1.0
    # Executing 1 build trigger...
    Step 1/1 : COPY src/ ${DOCROOT}/
     ---> 95f980256fa3
    Removing intermediate container 696ea40f41d9
    ...
  # viewing ONBUILD directive progress triggered by parent container image
  $ podman images
  ```
