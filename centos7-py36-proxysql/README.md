## 关于Dockerfile
Docker镜像构建文件，Centos7 + python3.6 + proxysql + librados2。

## 关于Dockerfile-centos7-python36
基于Centos7从源码安装python3.6的Docker镜像构建文件。   
* 安装其他python版本，请修改 `ENV PYTHON_VERSION "3.6.8"`

## 关于Dockerfile-evharbor-web
EVHarbor webserver Docker镜像构建文件。
* 启动镜像命令   
`docker run -dit -p 80:80 --privileged evharbor-web`



