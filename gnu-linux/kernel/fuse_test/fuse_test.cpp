/*
 * Copyright (C) 2016 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/fuse.h>
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <sys/inotify.h>
#include <sys/mount.h>
#include <sys/resource.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <vector>
#include <iostream>


#include "fuse.h"


static int fuse_setup(struct fuse* fuse, gid_t gid, mode_t mask) {
    char opts[256];

    fuse->fd = TEMP_FAILURE_RETRY(open("/dev/fuse", O_RDWR | O_CLOEXEC));
    if (fuse->fd == -1) {
        std::cerr << "failed to open fuse device" << std::endl;
        return -1;
    }

    umount2(fuse->dest_path, MNT_DETACH);

    snprintf(opts, sizeof(opts),
            "fd=%i,rootmode=40000,default_permissions,allow_other,user_id=%d,group_id=%d",
            fuse->fd, fuse->global->uid, fuse->global->gid);
    if (mount("/dev/fuse", fuse->dest_path, "fuse", MS_NOSUID | MS_NODEV | MS_NOEXEC | MS_NOATIME,
              opts) == -1) {
        std::cerr << "failed to mount fuse filesystem" << std::endl;
        return -1;
    }

    fuse->gid = gid;
    fuse->mask = mask;

    return 0;
}

static void* start_handler(void* data) {
    struct fuse_handler* handler = static_cast<fuse_handler*>(data);
    handle_fuse_requests(handler);
    return NULL;
}

static void run(const char* source_path, const char* dest_path, uid_t uid,
        gid_t gid, userid_t userid, bool multi_user, bool full_write) {
    struct fuse_global global;
    struct fuse fuse_default;
    struct fuse_handler handler_default;
    pthread_t thread_default;

    memset(&global, 0, sizeof(global));
    memset(&fuse_default, 0, sizeof(fuse_default));
    memset(&handler_default, 0, sizeof(handler_default));

    pthread_mutex_init(&global.lock, NULL);
    global.uid = uid;
    global.gid = gid;
    global.multi_user = multi_user;
    global.next_generation = 0;
    global.inode_ctr = 1;

    memset(&global.root, 0, sizeof(global.root));
    global.root.nid = FUSE_ROOT_ID; /* 1 */
    global.root.refcount = 2;
    global.root.namelen = strlen(source_path);
    global.root.name = strdup(source_path);
    global.root.userid = userid;
    global.root.uid = 0;
    global.root.under_android = false;

    // Clang static analyzer think strcpy potentially overwrites other fields
    // in global. Use snprintf() to mute the false warning.
    snprintf(global.source_path, sizeof(global.source_path), "%s", source_path);

    fuse_default.global = &global;

    global.fuse_default = &fuse_default;

    snprintf(fuse_default.dest_path, PATH_MAX, "%s", dest_path);

    handler_default.fuse = &fuse_default;

    handler_default.token = 0;

    umask(0);

    /* Multi-user storage is fully isolated per user, so "other"
        * permissions are completely masked off. */
    if (fuse_setup(&fuse_default, 0, 0006)) { 
        std::cerr << "failed to fuse_setup" << std::endl;
    }

    // Will abort if priv-dropping fails.
    //drop_privs(uid, gid);

    if (pthread_create(&thread_default, NULL, start_handler, &handler_default)) {
        std::cerr << "failed to pthread_create" << std::endl;
    }

    while (true) {
        sleep(1);
    }
}

static int usage() {
    std::cerr << "usage: sdcard <source_path> <dest_path>" << std::endl;
    return 1;
}

int main(int argc, char **argv) 
{
    const char *source_path = NULL;
    const char *dest_path = NULL;
    struct rlimit rlim;

    if (argc < 3) {
        return usage();
    }

    source_path = argv[1];
    dest_path = argv[2];

    rlim.rlim_cur = 8192;
    rlim.rlim_max = 8192;
    if (setrlimit(RLIMIT_NOFILE, &rlim) == -1) {
        std::cerr << "setting RLIMIT_NOFILE failed" << std::endl;
    }

    run(source_path, dest_path, getuid(), getgid(), 0, 1, 1);

    return 1;
}
