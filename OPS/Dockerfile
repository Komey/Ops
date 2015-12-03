FROM ubuntu:14.04

MAINTAINER Komey <lmh5257@live.cn>

ADD . /home/docker/code/ 

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server pwgen build-essential git python python-dev python-setuptools nginx sqlite3 supervisor

RUN easy_install pip && pip install uwsgi

RUN echo "daemon off;" >> /etc/nginx/nginx.conf && rm /etc/nginx/sites-enabled/default && ln -s /home/docker/code/nginx-app.conf /etc/nginx/sites-enabled/ && ln -s /home/docker/code/supervisor-app.conf /etc/supervisor/conf.d/

RUN pip install -r /home/docker/code/app/requirements.txt && chmod +x /home/docker/code/*.sh

VOLUME ["/home/docker/code/app"]
EXPOSE 80
CMD ["/home/docker/code/run.sh"]
