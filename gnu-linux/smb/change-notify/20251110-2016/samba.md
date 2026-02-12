Perform the following operations on the Samba server:
```sh
touch file
mkdir dir
# Windown enter dir/
touch dir/file1
mkdir dir/dir1
# Windows enter dir/dir1
touch dir/dir1/file11
mkdir dir/dir1/dir11
touch dir/dir1/file12
```

Capture packets in the virtual machine using the following command:
```sh
tcpdump --interface=any -w samba.pcap
```

Open the capture file in Wireshark and filter it with `smb2.cmd == 15`.

[The full capture file can be found on GitHub](https://github.com/chenxiaosonggithub/tmp/blob/master/gnu-linux/smb/change-notify/20251110-2016/samba.pcap)
([or on gitee](https://gitee.com/chenxiaosonggitee/tmp/blob/master/gnu-linux/smb/change-notify/20251110-2016/samba.pcap)).

# 20:17:17.201 Notify Request No.123 [Response in: 271]

```sh
SMB2 Header
    Message ID: 27
Notify Request (0x0f)
    StructureSize: 0x0020
        0000 0000 0010 000. = Fixed Part Length: 16
        .... .... .... ...0 = Dynamic Part: False
    Notify Flags: 0x0000
        .... .... .... ...0 = Watch Tree: False
    Output Buffer Length: 2048
    GUID handle File: 
        File Id: 7e556ff8-0000-0000-6b0e-2a3200000000
        [Frame handle opened: 85]
        [Frame handle closed: 274]
    Completion Filter: 0x00000015, File Name Change, Attribute Change, Last Write Change
        .... .... .... .... .... .... .... ...1 = File Name Change: Notify on changes to FILE NAME
        .... .... .... .... .... .... .... ..0. = Directory Name Change: Do NOT notify on changes to dir name
        .... .... .... .... .... .... .... .1.. = Attribute Change: Notify on changes to ATTRIBUTES
        .... .... .... .... .... .... .... 0... = Size Change: Do NOT notify on changes to size
        .... .... .... .... .... .... ...1 .... = Last Write Change: Notify on changes to LAST WRITE TIME
        .... .... .... .... .... .... ..0. .... = Last Access Change: Do NOT notify on changes to last access time
        .... .... .... .... .... .... .0.. .... = Created Change: Do NOT notify on changes to creation time
        .... .... .... .... .... .... 0... .... = EA Change: Do NOT notify on changes to EA
        .... .... .... .... .... ...0 .... .... = Security Change: Do NOT notify on changes to security
        .... .... .... .... .... ..0. .... .... = Stream Name Change: Do NOT notify on changes to stream name
        .... .... .... .... .... .0.. .... .... = Stream Size Change: Do NOT notify on changes to stream size
        .... .... .... .... .... 0... .... .... = Stream Write: Do NOT notify on changes to stream write
    Reserved: 00000000
```

# 20:17:17.202 Notify Response, Error: STATUS_PENDING No.124 [Response to: 123 270]

```sh
Notify Response (0x0f)
    StructureSize: 0x0009
        0000 0000 0000 100. = Fixed Part Length: 4
        .... .... .... ...1 = Dynamic Part: True
    Error Context Count: 0
    Reserved: 0x00
    Byte Count: 0
    Error Data: 21
```

# 20:17:29.666 Create Request;Notify Request No.239

## Create Request [Response in: 240]

```sh
Create Request (0x05)
    StructureSize: 0x0039
        0000 0000 0011 100. = Fixed Part Length: 28
        .... .... .... ...1 = Dynamic Part: True
    Oplock: No oplock (0x00)
    Impersonation level: Impersonation (2)
    Create Flags: 0x0000000000000000
    Reserved: 0000000000000000
    Access Mask: 0x00100081
        .... .... .... .... .... .... .... ...1 = Read: READ access
        .... .... .... .... .... .... .... ..0. = Write: NO write access
        .... .... .... .... .... .... .... .0.. = Append: NO append access
        .... .... .... .... .... .... .... 0... = Read EA: NO read extended attributes access
        .... .... .... .... .... .... ...0 .... = Write EA: NO write extended attributes access
        .... .... .... .... .... .... ..0. .... = Execute: NO execute access
        .... .... .... .... .... .... .0.. .... = Delete Child: NO delete child access
        .... .... .... .... .... .... 1... .... = Read Attributes: READ ATTRIBUTES access
        .... .... .... .... .... ...0 .... .... = Write Attributes: NO write attributes access
        .... .... .... ...0 .... .... .... .... = Delete: NO delete access
        .... .... .... ..0. .... .... .... .... = Read Control: Read access is NOT granted to owner, group and ACL of the SID
        .... .... .... .0.. .... .... .... .... = Write DAC: Owner may NOT write to the DAC
        .... .... .... 0... .... .... .... .... = Write Owner: Can NOT write owner (take ownership)
        .... .... ...1 .... .... .... .... .... = Synchronize: Can wait on handle to SYNCHRONIZE on completion of I/O
        .... ...0 .... .... .... .... .... .... = System Security: System security is NOT set
        .... ..0. .... .... .... .... .... .... = Maximum Allowed: Maximum allowed is NOT set
        ...0 .... .... .... .... .... .... .... = Generic All: Generic all is NOT set
        ..0. .... .... .... .... .... .... .... = Generic Execute: Generic execute is NOT set
        .0.. .... .... .... .... .... .... .... = Generic Write: Generic write is NOT set
        0... .... .... .... .... .... .... .... = Generic Read: Generic read is NOT set
    File Attributes: 0x00000000
        .... .... .... .... .... .... .... ...0 = Read Only: No
        .... .... .... .... .... .... .... ..0. = Hidden: No
        .... .... .... .... .... .... .... .0.. = System: No
        .... .... .... .... .... .... ...0 .... = Directory: No
        .... .... .... .... .... .... ..0. .... = Requires archived: No
        .... .... .... .... .... .... 0... .... = Normal: No
        .... .... .... .... .... ...0 .... .... = Temporary: No
        .... .... .... .... .... ..0. .... .... = Sparse: No
        .... .... .... .... .... .0.. .... .... = Reparse Point: Does NOT have an associated reparse point
        .... .... .... .... .... 0... .... .... = Compressed: Uncompressed
        .... .... .... .... ...0 .... .... .... = Offline: Online
        .... .... .... .... ..0. .... .... .... = Not Content Indexed: Is indexed by the content indexing service
        .... .... .... .... .0.. .... .... .... = Encrypted: No
        .... .... .... .... 0... .... .... .... = Integrity Stream: Does NOT have Integrity Support
        .... .... .... ..0. .... .... .... .... = No Scrub Data: Is not excluded from the data integrity scan
    Share Access: 0x00000007, Read, Write, Delete
        .... .... .... .... .... .... .... ...1 = Read: Object can be shared for READ
        .... .... .... .... .... .... .... ..1. = Write: Object can be shared for WRITE
        .... .... .... .... .... .... .... .1.. = Delete: Object can be shared for DELETE
    Disposition: Open (if file exists open it, else fail) (1)
    Create Options: 0x00000000
        .... .... .... .... .... .... .... ...0 = Directory: File being created/opened must not be a directory
        .... .... .... .... .... .... .... ..0. = Write Through: Writes need not flush buffered data before completing
        .... .... .... .... .... .... .... .0.. = Sequential Only: The file might not only be accessed sequentially
        .... .... .... .... .... .... .... 0... = Intermediate Buffering: Intermediate buffering is allowed
        .... .... .... .... .... .... ...0 .... = Sync I/O Alert: Operations NOT necessarily synchronous
        .... .... .... .... .... .... ..0. .... = Sync I/O Nonalert: Operations NOT necessarily synchronous
        .... .... .... .... .... .... .0.. .... = Non-Directory: File being created/opened must be a directory
        .... .... .... .... .... .... 0... .... = Create Tree Connection: Create Tree Connections is NOT set
        .... .... .... .... .... ...0 .... .... = Complete If Oplocked: Complete if oplocked is NOT set
        .... .... .... .... .... ..0. .... .... = No EA Knowledge: The client understands extended attributes
        .... .... .... .... .... .0.. .... .... = 8.3 Only: The client understands long file names
        .... .... .... .... .... 0... .... .... = Random Access: The file will not be accessed randomly
        .... .... .... .... ...0 .... .... .... = Delete On Close: The file should not be deleted when it is closed
        .... .... .... .... ..0. .... .... .... = Open By FileID: OpenByFileID is NOT set
        .... .... .... .... .0.. .... .... .... = Backup Intent: This is a normal create
        .... .... .... .... 0... .... .... .... = No Compression: Compression is allowed for Open/Create
        .... .... ...0 .... .... .... .... .... = Reserve Opfilter: Reserve Opfilter is NOT set
        .... .... ..0. .... .... .... .... .... = Open Reparse Point: Normal open
        .... .... .0.. .... .... .... .... .... = Open No Recall: Open no recall is NOT set
        .... .... 0... .... .... .... .... .... = Open For Free Space query: This is NOT an open for free space query
    Filename: dir
        Blob Offset: 0x00000078
        Blob Length: 6
    Blob Offset: 0x00000080
    Blob Length: 24
    ExtraInfo SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST
        Chain Element: SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
            Chain Offset: 0x00000000
            Tag: MxAc
                Blob Offset: 0x00000010
                Blob Length: 4
            Blob Offset: 0x00000018
            Blob Length: 0
            Data: NO DATA
```

## Notify Request [Response in: 285]

```sh
Notify Request (0x0f)
    StructureSize: 0x0020
        0000 0000 0010 000. = Fixed Part Length: 16
        .... .... .... ...0 = Dynamic Part: False
    Notify Flags: 0x0000
        .... .... .... ...0 = Watch Tree: False
    Output Buffer Length: 2048
    GUID handle
        File Id: ffffffff-ffff-ffff-ffff-ffffffffffff
    Completion Filter: 0x00000015, File Name Change, Attribute Change, Last Write Change
        .... .... .... .... .... .... .... ...1 = File Name Change: Notify on changes to FILE NAME
        .... .... .... .... .... .... .... ..0. = Directory Name Change: Do NOT notify on changes to dir name
        .... .... .... .... .... .... .... .1.. = Attribute Change: Notify on changes to ATTRIBUTES
        .... .... .... .... .... .... .... 0... = Size Change: Do NOT notify on changes to size
        .... .... .... .... .... .... ...1 .... = Last Write Change: Notify on changes to LAST WRITE TIME
        .... .... .... .... .... .... ..0. .... = Last Access Change: Do NOT notify on changes to last access time
        .... .... .... .... .... .... .0.. .... = Created Change: Do NOT notify on changes to creation time
        .... .... .... .... .... .... 0... .... = EA Change: Do NOT notify on changes to EA
        .... .... .... .... .... ...0 .... .... = Security Change: Do NOT notify on changes to security
        .... .... .... .... .... ..0. .... .... = Stream Name Change: Do NOT notify on changes to stream name
        .... .... .... .... .... .0.. .... .... = Stream Size Change: Do NOT notify on changes to stream size
        .... .... .... .... .... 0... .... .... = Stream Write: Do NOT notify on changes to stream write
    Reserved: 00000000
```

# 20:17:29.668 Notify Response, Error: STATUS_PENDING No.244 [Response to: 239]

```sh
SMB2 Header
    NT Status: STATUS_PENDING (0x00000103)
    Command: Notify (15)
Notify Response (0x0f)
    StructureSize: 0x0009
        0000 0000 0000 100. = Fixed Part Length: 4
        .... .... .... ...1 = Dynamic Part: True
    Error Context Count: 0
    Reserved: 0x00
    Byte Count: 0
    Error Data: 21
```

# 20:17:29.760 Cancel Request No.270 [Response in: 271]

```sh
SMB2 Header
    Message ID: 27
    Async Id: 0x000000000000001b
Cancel Request (0x0c)
    StructureSize: 0x0004
        0000 0000 0000 010. = Fixed Part Length: 2
        .... .... .... ...0 = Dynamic Part: False
    Unknown: 0000
```

# 20:17:29.760 Notify Response, Error: STATUS_CANCELLED No.271 [Response to: 123 270]

```sh
SMB2 Header
    Message ID: 27
    Async Id: 0x000000000000001b
Notify Response (0x0f)
    StructureSize: 0x0009
        0000 0000 0000 100. = Fixed Part Length: 4
        .... .... .... ...1 = Dynamic Part: True
    Error Context Count: 0
    Reserved: 0x00
    Byte Count: 0
    Error Data: 00
```

# 20:17:54.095 Notify Response No.285 [Response to: 239]

```sh
Notify Response (0x0f)
    StructureSize: 0x0009
        0000 0000 0000 100. = Fixed Part Length: 4
        .... .... .... ...1 = Dynamic Part: True
    Blob Offset: 0x00000048
    Blob Length: 24
    Out Data
        Notify Info
            Next Offset: 0x00000000
            Action: FILE_ACTION_ADDED (0x00000001)
            Filename Length: 10
            Filename: file1
```

