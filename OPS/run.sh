#!/bin/bash

echo "Hi~~~"


MODULE=${MODULE:-website}
echo "finding django project (module: ${MODULE})"
sed -i "s#module=website.wsgi:application#module=${MODULE}.wsgi:application#g" /home/docker/code/uwsgi.ini

if [ ! -f "/home/docker/code/app/manage.py" ]
then
	echo "creating basic django project (module: ${MODULE})"
	django-admin.py startproject ${MODULE} /home/docker/code/app/
fi

python /home/docker/code/app/manage.py migrate
/usr/bin/supervisord
exec /usr/sbin/sshd -D