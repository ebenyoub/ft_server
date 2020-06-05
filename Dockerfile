FROM		debian:buster
LABEL		maintainer="Elyas BENYOUB <ebenyoub@student.le-101.fr>"
WORKDIR		/ft_server
COPY		srcs /ft_server
RUN			apt-get update && apt-get upgrade -y && apt-get install -y figlet
EXPOSE		80 443
CMD         sh server.sh && tail -f /dev/null