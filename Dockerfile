FROM privateport/securefwd-openvpn

MAINTAINER SneakyScampi

WORKDIR /root
RUN apk update && apk upgrade \
	&& git clone https://github.com/privateport/openvpn-webca.git \ 
		&& apk add alpine-sdk autoconf automake libtool gettext bison flex ragel boost-dev | tee /tmp/install.txt \
		&& cd /root/openvpn-webca \
		&& npm install --unsafe-perm \ 
		&& apk del `grep 'Installing' /tmp/install.txt | awk {'print $3'} | xargs echo` && rm -rf /tmp/install.txt \

COPY config.sh /opt/
COPY start.sh /opt/

EXPOSE 3000/tcp
CMD ["/opt/start.sh"]
