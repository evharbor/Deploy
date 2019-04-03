#!/bin/bash

/etc/init.d/proxysql start

cd /home/uwsgi/webserver
python3 manage.py collectstatic --noinput

echo net.core.somaxconn = 1024 >> /etc/sysctl.conf && sysctl -p

./run_uwsgi.sh
/bin/bash



