FROM tiangolo/uwsgi-nginx-flask:python3.8-alpine

USER root

RUN apk update && apk upgrade

# Séparation en deux RUN
RUN apk add \
	python3-dev \
	musl-dev \
	openssl-dev \
	make \
	gcc \
	g++ \
	libffi-dev  # Ajouter libffi-dev pour résoudre l'erreur de cffi

RUN pip3 install --upgrade pip

RUN pip install setuptools

COPY requirements.txt /app

RUN pip install -r ./requirements.txt

COPY blog_project /app

# Copier la base de données dans le conteneur
COPY blog_project/blog/blog.db /app/blog.db
