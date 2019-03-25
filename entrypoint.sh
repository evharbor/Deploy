#!/bin/bash
#set -e

cd /home/uwsgi/webserver

python3 manage.py migrate

python3 manage.py collectstatic --noinput

#sysctl -w net.core.somaxconn=1024 
#sysctl -a | grep net.core.somaxconn
#python3 manage.py runserver 0.0.0.0:8000
./run_uwsgi.sh
/bin/bash
