翻译自[INSTALL](https://gitlab.com/wireshark/wireshark/-/blob/b6c161e1f4cca41d6fad248ecf29f443f57e8b25/INSTALL)。

另请参见 https://wiki.wireshark.org/Development/
以及位于 https://www.wireshark.org/docs/ 的《开发者指南》
和 doc/ 子目录中的相关文档。

安装
====

以下是适用于 Unix 及类 Unix 系统的安装说明。
这些并不是 Windows 系统的安装说明；Windows 的安装请参见
Wireshark 用户指南和 Wireshark 开发者指南，地址为
https://www.wireshark.org/docs/。

0. 这是软件。请自行承担风险。

1. 如果你希望构建 Wireshark，请确保已安装 Qt 和 GLib 的开发包。
   可先运行
   'pkg-config glib-2.0 --modversion'
   以检查是否安装了 GLib 2.x。
   然后运行
   'pkg-config Qt6Widgets --modversion'
   以检查是否安装了 Qt 6。
   如果没有，再尝试运行
   'pkg-config Qt5Widgets --modversion'
   以检查是否安装了 Qt 5。

   Wireshark 需要 Qt 5.15 或更高版本，但强烈推荐使用最新的 LTS 版本。
   使用 Qt 5 构建时需要 CMake 选项 '-DUSE_qt6=OFF'。
   Wireshark 需要 GLib 2.54.0 或更高版本。

   如果你需要安装或重新安装 GLib，可以在以下地址找到相关软件包：

        https://download.gnome.org/sources/glib/

   Qt 可在以下地址获取：

        https://www.qt.io/download

   如果你是通过二进制包安装 Qt 或 GLib，可能还需要安装对应的
   “开发”包；通常会有“用户”包和“开发者”包之分，前者不包含头文件等内容。
   例如，Red Hat 用户需要安装名为 “glib2-devel” 的 .rpm 包。

2. 如果你希望构建 Wireshark 的命令行版本 TShark，
   请确保已安装 GLib。检查方法见上面的注释 #1。

3. 如果你想抓包，请确保已安装 libpcap。
   最新的“官方”版本可以在以下地址找到：

        https://www.tcpdump.org

   如果你是通过二进制包安装 libpcap，可能还需要安装相应的
   “开发”包。例如，在 Debian 中可能有一个名为 “libpcap0” 的包，
   但它只包含共享库、版权说明、变更日志和 README.md 文件；
   你还需要安装 “libpcap-dev” 包才能获得头文件、非共享库以及 man 手册。
   类似地，Red Hat 用户需要在安装 “libpcap” .rpm 的同时，
   再安装 “libpcap-devel” .rpm。

4. 构建 Wireshark 需要 Python、flex 和 Asciidoctor。

5. 创建一个与源码目录分离的构建目录。
   该目录可以位于任意位置，但如果路径中包含空格，可能会遇到问题。

6. 在构建目录中运行
   'cmake <选项> <wireshark 源码路径>'。
   运行
   'cmake -LH <wireshark 源码路径>'
   可以显示完整的选项列表。
   《开发者指南》的 “Tool Reference” 章节中包含使用 CMake 的通用说明。
   一些 Wireshark 特有的选项如下：

    -G Ninja
        CMake 支持多种构建系统，包括 UNIX Make、MSBuild 和 Ninja。
        UNIX Make 是默认选项，但 Ninja 通常更快。

    -DBUILD_wireshark=OFF
        默认情况下，CMake 会尝试查找 Qt 库以构建 Wireshark（GUI 包分析器）。
        使用此选项可以禁用 GUI 版本 Wireshark 的构建。

    -DBUILD_tshark=OFF
        默认会构建命令行包分析器 TShark。
        使用此选项可以避免构建它。

    -DBUILD_editcap=OFF
        默认会构建抓包文件编辑程序。
        使用此选项可以避免构建它。

    -DBUILD_capinfos=OFF
        默认会构建抓包文件统计信息报告程序。
        使用此选项可以避免构建它。

    -DBUILD_captype=OFF
        默认会构建抓包类型报告程序。
        使用此选项可以避免构建它。

    -DBUILD_mergecap=OFF
        默认会构建抓包文件合并程序。
        使用此选项可以避免构建它。

    -DBUILD_reordercap=OFF
        默认会构建抓包文件重排序程序。
        使用此选项可以避免构建它。

    -DBUILD_text2pcap=OFF
        默认会构建十六进制转抓包文件的转换程序。
        使用此选项可以避免构建它。

    -DBUILD_dftest=OFF
        默认会构建显示过滤器编译器测试程序。
        使用此选项可以避免构建它。

    -DBUILD_randpkt=OFF
        默认会构建用于生成随机抓包文件的程序。
        使用此选项可以避免构建它。

    -DBUILD_dumpcap=OFF
        默认会构建网络流量抓包程序 dumpcap。
        使用此选项可以避免构建它。

    -DBUILD_rawshark=OFF
        默认会构建用于转储和分析原始 libpcap 数据的程序。
        使用此选项可以避免构建它。

    -DUSE_qt6=OFF
        默认情况下，如果需要 Qt，CMake 会尝试查找 Qt 6 库。
        使用此选项可以改为查找并使用 Qt 5。

    -DDUMPCAP_INSTALL_OPTION=suid
    -DDUMPCAP_INSTALL_OPTION=capabilities
        Wireshark 和 TShark 依赖 dumpcap 进行抓包。
        将该选项设置为 “suid” 会以 setuid root 权限安装 dumpcap，
        从而允许系统中的任意用户抓取实时流量。
        如果不希望这样，可以限制 dumpcap 的权限，仅允许特定用户或用户组运行，
        并将该选项设置为 “capabilities”。

        不推荐以 root 身份运行 Wireshark 或 TShark。

    -DENABLE_CAP=OFF
        默认情况下，如果 'cmake' 找到 libcap（POSIX capabilities 库），
        dumpcap 在以 setuid root 安装时，会在放弃 root 权限前
        尝试保留 CAP_NET_RAW 和 CAP_NET_ADMIN。
        使用此选项可以禁用该行为。

    -DENABLE_PCAP=OFF
        如果你希望构建一个只能分析抓包文件、但不能自行抓包的分析器，
        且系统中已安装 libpcap，
        或者你正在一个未安装 libpcap 的系统上构建 Wireshark
        （这种情况下只能构建无法抓包的版本），
        可以使用 -DENABLE_PCAP=OFF 来避免使用 libpcap。

    -DENABLE_ZLIB=OFF
        默认情况下，如果 'cmake' 找到 zlib（即 libz），
        wiretap 库将支持读取压缩的抓包文件。
        如果你安装了 zlib，但不希望将其集成到 wiretap 库中
        （该库被 Wireshark、TShark 以及抓包文件工具使用），
        可以使用此选项。

    -DENABLE_BROTLI=OFF
        默认情况下，如果 'cmake' 找到 brotli，
        wiretap 库将支持读取 brotli 压缩的抓包文件。
        如果你不希望启用该功能，可以使用此选项。

    -DENABLE_PLUGINS=OFF
        默认情况下，如果系统支持运行时可加载模块，
        包分析器将支持插件。
        使用此选项可以在不支持插件的情况下构建。

7. 运行 'cmake' 后，会看到一个所选选项的摘要。
   请确认该摘要符合你的预期。
   如果不符合，请使用新的选项重新运行 'cmake'。

8. 运行 'make'，
   如果你选择生成 Ninja 构建文件，则运行 'ninja'。
   希望你不会遇到任何问题。

9. 运行 './run/wireshark'、'./run/tshark' 或 './run/dumpcap'，
   确认程序可以正常工作。
   要抓取实时数据，你必须具有 root 权限。

10/a. 运行 'make install'。
   如果你使用的是支持 RPM 打包系统的发行版，可以运行：

        make wireshark_rpm

   或

        ninja wireshark_rpm

   来生成适用于你系统的可安装软件包。
   默认的安装路径是 /usr/local，
   因此你可能希望在 CMake 中传递
   -DCMAKE_INSTALL_PREFIX=/usr。

10/b. 如果你运行的是支持 APT（Debian/Ubuntu 等）的系统，
   请在解压或检出 Wireshark 源码后，立即在源码目录中运行：

        ln -sn packaging/debian
        dpkg-buildpackage -us -uc -rfakeroot

   （在运行 dpkg-buildpackage 之前，不需要先运行 CMake/make/Ninja 等）

如果在构建或安装过程中遇到问题，
你可以在 wireshark-users 和 wireshark-dev 邮件列表中寻求帮助
（详情见 https://www.wireshark.org/lists/），
或者访问 Wireshark 问答网站：
https://ask.wireshark.org 。
