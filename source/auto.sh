#! /bin/bash

# wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
# yum localinstall mysql57-community-release-el7-11.noarch.rpm
# yum -y install mysql-community-server


yum -y install glibc.i686
yum -y install xulrunner.i686
yum -y install libXtst.i686
yum -y install gcc gcc-c++ make zlib-devel

cd /root
tar xzvf dxf.tar 
tar xzvf GeoIP-1.4.8.tar

cd GeoIP-1.4.8
./configure
make
make install


#set password=password("xxxxxxxx");
#use mysql;
#grant all privileges on *.* to 'game'@'%' identified by 'uu5!^%jg' with grant option;

cd /home/dxf/
sed -i "s/192.168.200.131/47.115.180.128/g" `find . -type f -name "*.tbl"`
sed -i "s/192.168.200.131/47.115.180.128/g" `find . -type f -name "*.cfg"`