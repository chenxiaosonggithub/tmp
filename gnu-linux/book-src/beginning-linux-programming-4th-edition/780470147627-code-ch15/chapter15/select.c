/*  Begin as usual with the includes and declarations
    and then initialize inputs to handle input from the keyboard.  */

#include <sys/types.h>
#include <sys/time.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>

int main()
{
    char buffer[128]; // 用于存储读取的输入
    int result, nread; // result存储select返回值，nread存储读取的字节数

    fd_set inputs, testfds;
    struct timeval timeout;

    FD_ZERO(&inputs); // 清空文件描述符集合
    FD_SET(0,&inputs); // 将标准输入(文件描述符0)加入集合

/*  Wait for input on stdin for a maximum of 2.5 seconds.  */

    while(1) {
        testfds = inputs; // 复制文件描述符集合
        timeout.tv_sec = 2;
        timeout.tv_usec = 500000;

        result = select(FD_SETSIZE, &testfds, (fd_set *)0, (fd_set *)0, &timeout);

/*  After this time, we test result. If there has been no input, the program loops again.
    If there has been an error, the program exits.  */

        switch(result) {
        case 0:
            printf("timeout\n");
            break;
        case -1:
            perror("select");
            exit(1);

/*  If, during the wait, we have some action on the file descriptor,
    we read the input on stdin and echo it whenever an <end of line> character is received,
    until that input is Ctrl-D.  */

        default:
            if(FD_ISSET(0,&testfds)) {
                // 获取套接字或文件描述符的接收缓冲区中当前有多少字节的数据立即可读（即可供读取），并将这个数字存储到第三个参数所指向的整数中
                ioctl(0,FIONREAD,&nread); // FIONREAD 是 File I/O Number of bytes READy (to be read) 的缩写
                if(nread == 0) {
                    printf("keyboard done\n");
                    exit(0);
                }
                nread = read(0,buffer,nread); // 读取输入
                buffer[nread] = 0; // 添加字符串结束符
                printf("read %d from keyboard: %s", nread, buffer);
            }
            break;
        }
    }
}

