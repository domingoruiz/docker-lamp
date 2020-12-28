# LAMP Server on Docker
LAMP server mounted on Ubuntu 20.04 in a Docker container. There are two versions of this container. One with PHP5.6 and one with PHP7.0. This includes PHP, Mysql, Apache2 and Phpmyadmin. This container is very useful as a base for other containers.

## Implementation of this container
To do this you must download the image on your local computer. You can do this in two ways

For PHP7.0 you can do it in one of the following two ways:
```bash
docker pull ghcr.io/domingoruiz/docker-lamp:php7.0
```
or
```bash
wget https://github.com/domingoruiz/docker-lamp/archive/PHP7.0.zip
unzip PHP7.0.zip
cd PHP7.0/
docker image build -t docker-lamp-php7.0 .
```

For PHP5.6 also you can do it in one of the following two ways:
```bash
docker pull ghcr.io/domingoruiz/docker-lamp:php5.6
```
or
```bash
wget https://github.com/domingoruiz/docker-lamp/archive/PHP5.6.zip
unzip PHP5.6.zip
cd PHP5.6/
docker image build -t docker-lamp-php5.6 .
```

Once the image is downloaded we must start the container
```bash
docker container run -it -p 80:80 docker-lamp-php7.0
```
or
```bash
docker container run -it -p 80:80 docker-lamp-php5.6
```

Once started we will access inside the container to create the mysql user and load the application files
```bash
docker container exec CONTAINER_ID /bin/bash
```

Finally, we will turn off the container and create our own image with our program already loaded.
```bash
docker commit CONTAINER_ID IMAGE_NAME
```
