service proxysql start

cd /home/uwsgi/iharbor-s3
python3 manage.py collectstatic --noinput

./run_uwsgi.sh
tail -F /var/log/iharbor/uwsgi-iharbor-s3.log
