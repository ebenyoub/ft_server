FROM		debian:buster
LABEL		maintainer="Elyas BENYOUB <ebenyoub@student.le-101.fr>"
WORKDIR		/ft_server
COPY		srcs /ft_server
RUN		/ft_server/server.sh
EXPOSE		80 443
CMD		service mysql restart\
		&& service php7.3-fpm start\
		&& nginx -g 'daemon off;' 
