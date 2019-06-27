## 关于Dockerfile
Docker镜像构建文件，Centos7.6 + python3.6.8 + proxysql2.0.* + librados2-14.2.1 + python36-rados-14.2.1。


## 关于Dockerfile-evharbor-web
EVHarbor webserver Docker镜像构建文件。
* 镜像构建目录明细   
harbor   
├── ceph   
│   ├── ceph.client.admin.keyring   
│   └── ceph.conf   
├── Dockerfile (Dockerfile-evharbor-web)   
├── entrypoint.sh   
├── proxysql   
│   ├── proxysql.cnf   
│   └── proxysql.db   
└── webserver（服务软件工程目录）   

* 构建镜像   
`docker build -t harbor-web .`

* 启动镜像命令   
`docker run -dt -p 80:80 -v /var/log/evharbor/:/var/log/evharbor/ harbor-web`
