FROM debian:buster
LABEL maintainer="<ebenyoub@student.le-101.fr>"
WORKDIR /ft_server
COPY srcs /ft_server
EXPOSE 80 443
ENTRYPOINT ["sh", "server.sh"]
