FROM centos:7

RUN echo http_caching=none >> /etc/yum.conf \
    && echo $'[proxysql_repo] \n\
name= ProxySQL YUM repository \n\
baseurl=http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/centos/\$releasever \n\
gpgcheck=1 \n\
gpgkey=http://repo.proxysql.com/ProxySQL/repo_pub_key \n' > /etc/yum.repos.d/proxysql.repo \
    && cat /etc/yum.repos.d/proxysql.repo \
    && yum install -y proxysql \
    && yum install -y gcc mysql-devel \
    && yum install -y librados2-devel \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN yum install epel-release -y \
    && yum install https://centos7.iuscommunity.org/ius-release.rpm -y \
    && yum install python36u -y \
    && ln -s /bin/python3.6 /bin/python3 \
    && yum install -y python36u-devel \
    && yum install python36u-pip -y \
    && ln -s /bin/pip3.6 /bin/pip3 \
    && pip3 install --upgrade pip \
    && yum clean all \
    && rm -rf /var/cache/yum

