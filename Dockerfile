
FROM centos:7

MAINTAINER Ins

RUN mkdir -p /home/uwsgi/webserver
WORKDIR /home/uwsgi/webserver

RUN mkdir -p /etc/ceph
COPY ceph_conf/ /etc/ceph

RUN yum install epel-release -y
RUN yum install https://centos7.iuscommunity.org/ius-release.rpm -y
RUN yum install python36u -y
RUN yum install python36u-devel -y
RUN ln -s /bin/python3.6 /bin/python3
RUN yum install python36u-pip -y
RUN ln -s /bin/pip3.6 /bin/pip3
RUN pip3 install --upgrade pip
RUN yum install mysql-devel -y
RUN yum install gcc -y
RUN yum install librados2-devel -y


COPY ./webserver /home/uwsgi/webserver
RUN pip3 install -r requirements.txt

COPY rados.so /home/uwsgi/webserver/utils/oss
COPY security_settings.py /home/uwsgi/webserver/webserver
COPY entrypoint.sh /
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
