#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>

int main() {
    const char *filename = "/mnt/file";
    int buf_size = 100 * 1024 * 1024; // 读100M
    char *buffer = malloc(buf_size);
    ssize_t bytes_read;
    
    // 打开文件
    int fd = open(filename, O_RDONLY, 0644);
    if (fd == -1) {
        perror("无法打开文件");
        return 1;
    }

    printf("文件已打开 (fd=%d)\n", fd);
    
    // 读取并显示文件前4096字节
    lseek(fd, 0, SEEK_SET);
    bytes_read = read(fd, buffer, buf_size - 1);
    if (bytes_read > 0) {
        buffer[bytes_read] = '\0';
        printf("读了 %zd 字节:\n", bytes_read);
    }
    // 无限循环等待
    while (1) {
        sleep(1);
    }
    
    // 这行代码永远不会执行
    close(fd);
    return 0;
}

