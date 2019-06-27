#!/bin/bash

service proxysql start

cd /home/uwsgi/webserver
python3 manage.py collectstatic --noinput

./run_uwsgi.sh
/bin/bash

