.. _server-build:

============================
服务器搭建笔记
============================


基本配置
~~~~~~~~~~~~~~~~~~~~~

==========  ================ ===========
hw          model            ps
==========  ================ ===========
CPU         E5-2680v3        12C 24T LGA2011
GPU         hd5450-256m      hdmi+vga
board       huanan-x99-8md4  1 cpu socket
RAM         micron-d4-2133   16Gx2
SSD         PM981A 256G      server2016 + ubuntu18
HDD         segeate Exos 8T       
power       dk500w gold
fan         ak120mini-133mm  single fan
==========  ================ ===========

服务器整体架构
~~~~~~~~~~~~~~~~~~~~~
使用ubuntu18.04 LTS desktop作为宿主host，在host上运行者多个KVM虚拟机（guest os。）
每个guest os一般运行某种服务。例如目前有4个guest os分别是

.. 1. fs.tmz.com       nextcloud file-share
.. #. cf.tmz.com:8090  confluence
.. #. gitlab.tmz.com   gitlab
.. #. samba.tmz.com    samba storage

=============== ===============  ==================== =================
guest name          os             service             url
=============== ===============  ==================== =================
tmz-fs          ubuntu20 server  nextcloud file share fs.tmz.com
tmz-cf          ubuntu20 server  confluence           cf.tmz.com:8090
tmz-gitlab      ubuntu20 server  gitlab               gitlab.tmz.com
tmz-samba       ubuntu20 server  samba file share     samba.tmz.com
=============== ===============  ==================== =================

系统安装
~~~~~~~~~~~~~~~~~~~~~
- windows server 2016 standard
- Ubuntu18.04-LTS

``安装在SSD, grub引导``

1. 格式化ssd GPT格式 
#. win占前128G空间，留128G空闲给ubuntu
#. 进bios改启动项 UEFI only
#. rufus+server16.iso,NTFS,GPT+UEFI刻录server2016启动盘
#. 安装windows server2016 第一个os完成.
#. 刻录ubuntu18 desktop 启动光盘。
#. 安装ubuntu18 桌面版作为服务器宿主机。


如下表所示 宿主机里跑n个虚拟机

==========  ================ ===========
fs-vm1          git-vm2        cf-vm3
虚拟机4          vm5               vm6
==========  ================ ===========
宿主机（host machine） tmz-svr
========================================

系统配置 ubuntu
~~~~~~~~~~~~~~~~~~~~~

- 更换apt源为aliyun或者清华源

::

    sudo cp /etc/apt/source.list /etc/apt/source.list.bak #备份源文件
    sudo gedit /etc/apt/source.list

更改为如下内容

::

    deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

    deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

    deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

    deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

    deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse

::

    sudo apt update
    sudo apt upgrade

- 配置静态ip
    - netplan配置表
- 查看HDD主存储硬盘fdisk -l  fdisk /dev/sda进入磁盘进行分区，新建卷，等操作
::

    fdisk -l  
    fdisk /dev/sda

- 完成后格式化一下
::

    mkfs.ext4 /dev/sda1

- 挂载磁盘到某个目录

::

    sudo mkdir /kvm-storage
    sudo mount /dev/sda1 /kvm-storage
    sudo vi /etc/fstab  #添加自动挂载配置

- 安装kvm虚拟机以及GUI管理软件

::

    sudo apt install qemu qemu-kvm libvirt-bin  bridge-utils  virt-manager
    

- 添加虚拟桥接网卡br0, ensxx, dhcp
- 使用ubuntu20-server-xx.iso 


安装Ubuntu20 server到kvm后，启动，网络使用桥接设备br0
更新apt。upgrade。之后安装snap国内镜像

::

    sudo snap install snap-store
    

完成后重启再执行

::

    sudo snap install nextcloud
    sudo snap install snap-store-proxy  #如果下载速度慢 先装一下这个
