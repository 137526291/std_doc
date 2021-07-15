===========================
linux study note.
===========================

poll用于查询是否有可读数据例如请求POLLIN
fds数组保存需要查询的所有句柄
第三个参数是多久查询一次  ms
当查询到了，fds对应的revents==poll_req否则 =0.

man xxxx可以寻找函数帮助和所需头文件。一般在2 3 7页
man [page] <function>

1. 注册signal的handler
signal(SIGIO, my_sig_handler);  //<signal.h>

void my_sig_handler(int sig) {
    struct input_event ie;
    while (read(fd, &ie, sizeof(ie)) == sizeof(ie)) {
        printf("xx %d", ie.xxx);
    }
}

2. fd = open("dev/xxx", O_RDWR|O_NONBLOCK);
3. fcntl(fd, F_SETOWN, getpid()) //可获取当前app的pid 用于传给驱动.有事件时驱动才能通知到app

flag = fcntl(fd, F_GETFL);//获取之前的flag
fcntl(fd, F_SETFL, flag | F_ASYNC);设置异步通知类似中断

fork

linux socket net  server
--------------------------------
1. sockServer = socket(xxx)
#. bind
#. listen
#. accept
#. send/recv


linux socket net  client
--------------------------------
1. sockClient = socket(xxx)
#. bind
#. connect
#. send/recv


fork函数
--------------------------------
1. 主进程的fork会返回非0， 子进程的fork返回0
2. fork用于复制一份，新开一个子进程并开始执行
3. 可以用于支持服务器程序的多个tcp连接

多线程 pthread
--------------------------------
1. 简单讲就是多线程只有1个main
2. ./xx & 进入后台执行。 使用ps -T查看  PID和SPID就是进程号和线程号。
3. 编译时需要链接 -lpthread
4. 使用semaphore来同步线程，例如通知/等待通知 接收到key等等sem_t xx;
5. 使用mutex来保护共享资源