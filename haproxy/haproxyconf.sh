#!/usr/bin/bash
version=2.0
build=2.0.5
yum update -y
yum install gcc pcre-static pcre-devel wget tar nmap nano -y
wget https://www.haproxy.org/download/$version/src/haproxy-$build.tar.gz -O ~/haproxy.tar.gz
tar xzvf ~/haproxy.tar.gz -C ~/
cd ~/haproxy-$build
make TARGET=linux-glibc
make install
mkdir -p /etc/haproxy
mkdir -p /var/lib/haproxy 
touch /var/lib/haproxy/stats
ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy
cp ~/haproxy-$build/examples/haproxy.init /etc/init.d/haproxy
chmod 755 /etc/init.d/haproxy
systemctl daemon-reload
chkconfig haproxy on
useradd -r haproxy
haproxy -v
