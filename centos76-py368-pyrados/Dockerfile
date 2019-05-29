FROM centos:centos7.6.1810 

RUN echo http_caching=none >> /etc/yum.conf \
    && echo $'[proxysql_repo] \n\
name= ProxySQL YUM repository \n\
baseurl=http://repo.proxysql.com/ProxySQL/proxysql-1.4.x/centos/\$releasever \n\
gpgcheck=1 \n\
gpgkey=http://repo.proxysql.com/ProxySQL/repo_pub_key \n' > /etc/yum.repos.d/proxysql.repo \
    && cat /etc/yum.repos.d/proxysql.repo \
    && yum install -y proxysql \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN yum install epel-release -y \
    && yum install http://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/python36-3.6.8-1.el7.x86_64.rpm -y \
    && yum install http://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/p/python36-devel-3.6.8-1.el7.x86_64.rpm -y \
    && yum install python36-pip -y \
    && pip3 install --upgrade pip \
    && yum install http://download.ceph.com/rpm-nautilus/el7/x86_64/librados2-14.2.1-0.el7.x86_64.rpm -y \
    && yum install http://download.ceph.com/rpm-nautilus/el7/x86_64/python36-rados-14.2.1-0.el7.x86_64.rpm -y \
    && yum clean all \
    && rm -rf /var/cache/yum
    