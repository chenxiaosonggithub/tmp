20250906统计。

# 代码行数

```sh
cat include/net/mptcp.h | wc -l # 340
cat include/trace/events/mptcp.h | wc -l # 184
cat include/uapi/linux/mptcp*.h | wc -l # 280
cat net/mptcp/* | wc -l # 17517
cat tools/testing/selftests/bpf/*/*mptcp*.[ch] | wc -l # 729
cat tools/testing/selftests/net/mptcp/* | wc -l # 13107
```

# `net/mptcp/`

```sh
git log --follow --format='%aN <%aE>' net/mptcp/ | sort | uniq -c | sort -nr
    400 Paolo Abeni <pabeni@redhat.com>
    259 Geliang Tang <geliang@kernel.org>
    110 Florian Westphal <fw@strlen.de>
    101 Matthieu Baerts (NGI0) <matttbe@kernel.org>
     47 Eric Dumazet <edumazet@google.com>
     41 Mat Martineau <martineau@kernel.org>
     33 Matthieu Baerts <matttbe@kernel.org>
     26 Davide Caratti <dcaratti@redhat.com>
     12 Peter Krystad <peter.krystad@linux.intel.com>
     12 Kishen Maloor <kishen.maloor@intel.com>
     10 Jianguo Wu <wujianguo@chinatelecom.cn>
      8 Yonglong Li <liyonglong@chinatelecom.cn>
      8 Menglong Dong <imagedong@tencent.com>
      8 Jason Xing <kernelxing@tencent.com>
      7 Kuniyuki Iwashima <kuniyu@google.com>
      7 Jakub Kicinski <kuba@kernel.org>
      5 Maxim Galaganov <max@internet.ru>
      5 Geert Uytterhoeven <geert@linux-m68k.org>
      5 Dmytro Shytyi <dmytro@shytyi.net>
      4 Christoph Paasch <cpaasch@apple.com>
      4 Christoph Hellwig <hch@lst.de>
      3 Eric Biggers <ebiggers@google.com>
      2 YueHaibing <yuehaibing@huawei.com>
      2 Yue Haibing <yuehaibing@huawei.com>
      2 YonglongLi <liyonglong@chinatelecom.cn>
      2 Yangbo Lu <yangbo.lu@nxp.com>
      2 Wei Yongjun <weiyongjun1@huawei.com>
      2 Todd Malsbary <todd.malsbary@linux.intel.com>
      2 Thomas Haller <thaller@redhat.com>
      2 Joel Granados <joel.granados@kernel.org>
      2 Gregory Detal <gregory.detal@gmail.com>
      2 Gang Yan <yangang@kylinos.cn>
      2 Edward Adam Davis <eadavis@qq.com>
      2 Benjamin Hesmans <benjamin.hesmans@tessares.net>
      1 Ye Bin <yebin10@huawei.com>
      1 Yan Zhai <yan@cloudflare.com>
      1 Yajun Deng <yajun.deng@linux.dev>
      1 Xiang Yang <xiangyang3@huawei.com>
      1 Wan Jiabing <wanjiabing@vivo.com>
      1 Tim Gardner <tim.gardner@canonical.com>
      1 Thorsten Blum <thorsten.blum@linux.dev>
      1 Thomas Weißschuh <linux@weissschuh.net>
      1 Thomas Gleixner <tglx@linutronix.de>
      1 Shi-Sheng Yang <fourcolor4c@gmail.com>
      1 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
      1 Rikard Falkeborn <rikard.falkeborn@gmail.com>
      1 Poorva Sonparote <psonparo@redhat.com>
      1 Peilin Ye <peilin.ye@bytedance.com>
      1 Pedro Falcato <pfalcato@suse.de>
      1 Oliver Hartkopp <socketcan@hartkopp.net>
      1 Nico Pache <npache@redhat.com>
      1 Nicolas Rybowski <nicolas.rybowski@tessares.net>
      1 MoYuanhao <moyuanhao3676@163.com>
      1 moyuanhao <moyuanhao3676@163.com>
      1 Maxim Mikityanskiy <maxtram95@gmail.com>
      1 Martin KaFai Lau <kafai@fb.com>
      1 Krister Johansen <kjlx@templeofstupid.com>
      1 Kees Cook <kees@kernel.org>
      1 Johannes Berg <johannes.berg@intel.com>
      1 Joel Granados <joel.granados@gmail.com>
      1 Jens Axboe <axboe@kernel.dk>
      1 Jean Sacren <sakiwit@gmail.com>
      1 Ingo Molnar <mingo@kernel.org>
      1 Ido Schimmel <idosch@nvidia.com>
      1 Herbert Xu <herbert@gondor.apana.org.au>
      1 Gustavo A. R. Silva <gustavoars@kernel.org>
      1 Eugene Syromiatnikov <esyr@redhat.com>
      1 Dmitry Kandybka <d.kandybka@gmail.com>
      1 David S. Miller <davem@davemloft.net>
      1 David Howells <dhowells@redhat.com>
      1 Dan Carpenter <error27@gmail.com>
      1 Christoph Paasch <cpaasch@openai.com>
      1 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
      1 Chen Wandun <chenwandun@huawei.com>
      1 Breno Leitao <leitao@debian.org>
      1 Bo YU <tsu.yubo@gmail.com>
      1 Bhaskar Chowdhury <unixbhaskar@gmail.com>
      1 Asbjørn Sloth Tønnesen <ast@fiberby.net>
      1 Arthur Mongodin <amongodin@randorisec.fr>
      1 Al Viro <viro@zeniv.linux.org.uk>
      1 Alexander Mikhalitsyn <alexander@mihalicyn.com>
      1 Alexander Aring <aahringo@redhat.com>
```

# `include/net/mptcp.h`

```sh
git log --follow --format='%aN <%aE>' include/net/mptcp.h | sort | uniq -c | sort -nr
     15 Geliang Tang <geliang@kernel.org>
      8 Florian Westphal <fw@strlen.de>
      6 Paolo Abeni <pabeni@redhat.com>
      5 Peter Krystad <peter.krystad@linux.intel.com>
      5 Mat Martineau <martineau@kernel.org>
      2 Matthieu Baerts (NGI0) <matttbe@kernel.org>
      2 Matthieu Baerts <matttbe@kernel.org>
      2 Christoph Paasch <cpaasch@apple.com>
      1 YueHaibing <yuehaibing@huawei.com>
      1 Jiri Olsa <jolsa@kernel.org>
      1 Jianguo Wu <wujianguo@chinatelecom.cn>
      1 Gregory Detal <gregory.detal@gmail.com>
      1 Geert Uytterhoeven <geert@linux-m68k.org>
      1 Davide Caratti <dcaratti@redhat.com>
```

# `include/trace/events/mptcp.h`

```sh
git log --follow --format='%aN <%aE>' include/trace/events/mptcp.h | sort | uniq -c | sort -nr
      7 Geliang Tang <geliang@kernel.org>
      1 Matthieu Baerts (NGI0) <matttbe@kernel.org>
      1 Eric Dumazet <edumazet@google.com>
```

# `include/uapi/linux/mptcp.h`

```sh
git log --follow --format='%aN <%aE>' include/uapi/linux/mptcp.h | sort | uniq -c | sort -nr
      7 Geliang Tang <geliang@kernel.org>
      6 Florian Westphal <fw@strlen.de>
      5 Paolo Abeni <pabeni@redhat.com>
      4 Davide Caratti <dcaratti@redhat.com>
      3 Kishen Maloor <kishen.maloor@intel.com>
      1 Ossama Othman <ossama.othman@intel.com>
      1 Matthieu Baerts <matttbe@kernel.org>
```

# `include/uapi/linux/mptcp_pm.h`

```sh
git log --follow --format='%aN <%aE>' include/uapi/linux/mptcp_pm.h | sort | uniq -c | sort -nr
      2 Matthieu Baerts (NGI0) <matttbe@kernel.org>
      2 Jakub Kicinski <kuba@kernel.org>
      2 Davide Caratti <dcaratti@redhat.com>
```

