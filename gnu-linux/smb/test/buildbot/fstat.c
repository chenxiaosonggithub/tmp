#include <stdio.h>
#include <fcntl.h>
#include <err.h>
#include <sys/stat.h>

int main(int argc, char *argv[])
{
	const char *path;
	struct stat stbuf;
	int res;
	int fd;

	if (argc != 2) {
		fprintf(stderr, "usage: %s path\n", argv[0]);
		return 1;
	}

	path = argv[1];
	fd = open(path, O_RDONLY);
	if (fd == -1)
		err(1, "open(\"%s\")", path);

	res = fstat(fd, &stbuf);
	if (res == -1)
		err(1, "fstat(%i)", fd);
	printf("%s nlink: %lu\n", path, (unsigned long) stbuf.st_nlink);

	return 0;
}
