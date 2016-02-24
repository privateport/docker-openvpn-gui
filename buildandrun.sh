docker stop privateport/openvpn-gui
docker rm privateport/openvpn-gui
docker build -t privateport/openvpn-gui .
docker run --rm -p 3000:3000 -v /docker.persistant/openvpn-gui:/persistant -v /docker.persistant/securefwd-openvpn:/persistant/openssl --hostname openvpn-gui --name openvpn-gui -it privateport/openvpn-gui $1 $2 $3 $4 $5 $6

