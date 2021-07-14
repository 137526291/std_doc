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