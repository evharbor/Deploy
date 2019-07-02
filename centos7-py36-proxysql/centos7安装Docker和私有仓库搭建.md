环境： 
虚拟机1：159.226.235.105，centos-7  私有仓库服务器 
虚拟机2：159.226.235.106，centos-7 

## 安装Docker
* 卸载旧版本(如果安装过旧版本的话)  
`yum remove docker  docker-common docker-selinux docker-engine`   
* 设置yum源
`yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo`   
* 可以查看所有仓库中所有docker版本，并选择特定版本安装   
`yum list docker-ce --showduplicates | sort -r`   
* 安装docker   
`yum install docker-ce`   
* 启动并加入开机启动  
```
systemctl start docker
systemctl enable docker
```
* 验证安装成功   
`docker run hello-world`   


##  拉取registry镜像 
registry是docker官方提供的搭建私有仓库的镜像，用这个镜像运行起来的容器就是一个私有仓库；
`docker pull registry:latest`

## 设置用户和密码
创建保存账号密码的文件,用户名username,密码password,请自行设置自己密码和用户名。
```
cd /opt/docker-registry/
mkdir auth
docker run --entrypoint htpasswd registry -Bbn username password > auth/htpasswd
```

## 运行registry镜像
```
docker run -d -p 5000:5000 \
--restart=always \
--name private-docker-registry \
--privileged=true \
-v /opt/docker-registry:/var/lib/registry \
-v /opt/docker-registry/auth:/auth \
-e "REGISTRY_AUTH=htpasswd" \
-e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
-e  REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
registry
```

说明：  
* “-d”表示容器在后台运行。
* “-p 5000:5000”表示将容器的5000端口映射到虚拟机的5000端口。  
* “–restart=always”表示容器随着docker启动而启动，同时若容器异常终止，会自动启动；  
实测表明，使用“docker stop”命令停止容器后，此参数不会让容器自动重启。  
* “–name private-docker-registry”设置容器名。  
* “–privileged=true”使容器真正具有容器内的root权限。  
* “-v /opt/docker-registry:/var/lib/registry”将容器中的“/var/lib/registry”(默认情况下存放镜像的仓库)目录
映射到虚拟机159.226.235.105本地的“/opt/docker-registry”(即实际存放镜像的仓库),这样如果容器被删除，
则存放于容器中的镜像也会丢失;   


## 私有仓库的使用  
### 将镜像推送到私有仓库 
* 让docker使用HTTP而不是HTTPS来访问我们刚搭建的私有仓库   
  
编辑docker配置文件“/etc/docker/daemon.json”，内容如下(ip地址改为自己ip)：
```json
{
  "insecure-registries": [
    "159.226.235.105:5000"
  ]
}
```
重启docker，`systemctl restart docker.service`  

* 登录
`docker login 159.226.235.105:5000`,按提示输入自己设置的用户名和密码。

* 将镜像推送到私有仓库   
以__hello-world__镜像为例，先修改现有镜像的标签：    
`docker tag hello-world 159.226.235.105:5000/hello-world:v0.0.1`   
说明：
这个命令为我之前下载的hello-world镜像新建了一个REPOSITORY和TAG。我们在原有的REPOSITORY之前
增加了“59.226.235.105:5000/”，这就是我们刚搭建的私有仓库的地址。docker在push和pull时会使用REPOSITORY属性
中指定的地址作为私有仓库地址，如果REPOSITORY属性中没有指定，会使用docker默认的仓库地址。
命令中还修改了镜像的TAG属性，即v0.0.1，这个属性可改可不改，如果命令中不指定TAG属性，会使用原有的TAG属性，即“latest”。   
将镜像推送到私有仓库:  
`docker push 159.226.235.105:5000/hello-world:v0.0.1`

### 从私有仓库拉取镜像 
`docker pull 159.226.235.105:5000/hello-world:v0.0.1`  



