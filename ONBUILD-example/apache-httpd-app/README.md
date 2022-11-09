## How to build the apache-httpd-app contianer images?

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
  # viewing ONBUILD directive appeared
  $ podman images
  ```
