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
sudo mkdir -p /etc/haproxy
sudo mkdir -p /var/lib/haproxy 
sudo touch /var/lib/haproxy/stats
sudo ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy
sudo cp ~/haproxy-$build/examples/haproxy.init /etc/init.d/haproxy
sudo chmod 755 /etc/init.d/haproxy
sudo systemctl daemon-reload
sudo chkconfig haproxy on
sudo useradd -r haproxy
haproxy -v
