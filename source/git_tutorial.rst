============================
git tutorial
============================

gitee.com是国内速度非常快的一个代码托管平台，对开源仓库友好，私有最多只能有5个开发者。
转战对私有仓库中小型公司使用友好的coding.net  目前公司项目主要托管在coding.net
仓库可以自由设置共有私有与权限，方便

git安装与注册gitee账号/coding账号
------------------------
1. 先在gitee上注册账号。记住用户名如tmz 邮箱如tmz@ironmz.com
2. 使用choco安装git或者去下载客户端安装都可以   
    ::
    
        choco install git

3. 配置本地git用户名和密码
    ::

        git config --global user.name tmz
        git config --global user.email tmz@ironmz.com

#. 生成ssh-key公钥以及添加到gitee服务器上 作为自己的凭证 命令行输入
    ::

        ssh-keygen  #一路回车直到生成指纹
    
#. 将公钥文件内容复制到剪贴板 到gitee网站 点击自己头像 添加ssh-确定
    ::

        clip < ~/.ssh/id_rsa.pub    

    .. image:: imgs/git/gitee-ssh.png
        :scale: 100%


#. 有sshkey之后，如果你在某个代码仓库有权限，则可以从网站拉取代码到本机了例如
    ::

        git clone git@gitee.com:langgoc/zephyr.git


git的可视化学习
你对 Git 感兴趣吗？那么算是来对地方了！ “Learning Git Branching” 可以说是目前为止最好的教程了，在沙盒里你能执行相应的命令，还能看到每个命令的执行情况； 通过一系列刺激的关卡挑战，逐步深入的学习 Git 的强大功能，在这个过程中你可能还会发现一些有意思的事情。
关闭这个对话框以后，你会看到我们提供的许多关卡。如果你是初学者，从第一关开始逐个向后挑战就是了。 而如果你已经入门了，可以略过前面，直接挑战后面更有难度的关卡。

https://learngitbranching.js.org/?locale=zh_CN

史上最浅显易懂的Git教程！ 只需要学习前4章即可。
https://www.liaoxuefeng.com/wiki/896043488029600


前期最常用命令：

初始化本地仓库

::

    git init


::

    git add .   //添加目录下所有东西到暂存区


::

    git commit -m "提交记录，新增xxx 修复xxx 。。。等"

::

    git push origin master   //推算到远程仓库


::

    git pull origin master   //拉取远程仓库到本地