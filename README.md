## The Deployment of the evharbor in docker enviroment.

### Install docker (CentOS)
1. Uninstall old versions.

```
sudo yum remove -y docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine
```

2. Install required packages

```
sudo yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
```

3. Set up the stable repository

```
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
```

4. Install docker-ce

```
sudo yum -y install docker-ce
```

### Build the image
1. Collect the config files here include:
    ceph_conf(ceph config), 
    proxysql.cnf(proxysql config), 
    rados.so(rados read and write), 
    security_settings.py(django settings)

2. Build

```
docker build -t webserver_web -f Dockfile_web .
docker build -t webserver_db -f Dockfile_db .
```

### Deploy the service

1. Docker-compose in single node
```
docker-compose up -d
```

