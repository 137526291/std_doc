============================
DXF外网架设centos7 阿里云
============================

更新软件源
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
yum makecache   

安装依赖
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
yum -y install glibc.i686
yum -y install xulrunner.i686
yum -y install libXtst.i686
yum -y install gcc gcc-c++ make zlib-devel


安装mysql
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
yum install -y mysql mysql-server mysql-devel


提取本地服务端文件
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd /home
tar czvf dxf.tar dxf
tar czvf GeoIP.tar Geoip

将这两个包上传到云端的/root下，并编译安装geoip
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd /root
tar xzvf dxf.tar 
tar xzvf GeoIP.tar

cd GeoIP
./configure
make
make install
