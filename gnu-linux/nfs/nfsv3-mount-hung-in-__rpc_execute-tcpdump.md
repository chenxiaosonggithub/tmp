使用`rpc.programversion == 3`过滤。

# 172640	2025-11-12 11:03:45.406103	10.10.39.236	10.10.8.203	MOUNT	160	V3 EXPORT Call (Reply In 174697)	934	2050

```sh
Frame 172640: 160 bytes on wire (1280 bits), 160 bytes captured (1280 bits)
    Encapsulation type: Linux cooked-mode capture v1 (25)
    Arrival Time: Nov 12, 2025 11:03:45.406103000 中国标准时间
    UTC Arrival Time: Nov 12, 2025 03:03:45.406103000 UTC
    Epoch Arrival Time: 1762916625.406103000
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 0.000000000 seconds]
    [Time delta from previous displayed frame: 0.000000000 seconds]
    [Time since reference or first frame: 2.853940000 seconds]
    Frame Number: 172640
    Frame Length: 160 bytes (1280 bits)
    Capture Length: 160 bytes (1280 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:ethertype:ip:tcp:rpc]
    [Coloring Rule Name: TCP]
    [Coloring Rule String: tcp]
Linux cooked capture v1
    Packet type: Sent by us (4)
    Link-layer address type: Ethernet (1)
    Link-layer address length: 6
    Source: ae:1b:04:76:46:b4 (ae:1b:04:76:46:b4)
    Unused: 4153
    Protocol: IPv4 (0x0800)
Internet Protocol Version 4, Src: 10.10.39.236, Dst: 10.10.8.203
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 144
    Identification: 0x7435 (29749)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 64
    Protocol: TCP (6)
    Header Checksum: 0x8168 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 10.10.39.236
    Destination Address: 10.10.8.203
    [Stream index: 450]
Transmission Control Protocol, Src Port: 934, Dst Port: 2050, Seq: 1, Ack: 1, Len: 92
    Source Port: 934
    Destination Port: 2050
    [Stream index: 2155]
    [Stream Packet Number: 10]
    [Conversation completeness: Complete, WITH_DATA (31)]
        ..0. .... = RST: Absent
        ...1 .... = FIN: Present
        .... 1... = Data: Present
        .... .1.. = ACK: Present
        .... ..1. = SYN-ACK: Present
        .... ...1 = SYN: Present
        [Completeness Flags: ·FDASS]
    [TCP Segment Len: 92]
    Sequence Number: 1    (relative sequence number)
    Sequence Number (raw): 1876373053
    [Next Sequence Number: 93    (relative sequence number)]
    Acknowledgment Number: 1    (relative ack number)
    Acknowledgment number (raw): 3990202146
    1000 .... = Header Length: 32 bytes (8)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 126
    [Calculated window size: 64512]
    [Window size scaling factor: 512]
    Checksum: 0x454d [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - Timestamps: TSval 3835185478, TSecr 2639940405
            Kind: Time Stamp Option (8)
            Length: 10
            Timestamp value: 3835185478
            Timestamp echo reply: 2639940405
    [Timestamps]
        [Time since first frame in this TCP stream: 0.000152000 seconds]
        [Time since previous frame in this TCP stream: 0.000060000 seconds]
    [SEQ/ACK analysis]
        [iRTT: 0.000086000 seconds]
        [Bytes in flight: 92]
        [Bytes sent since last PSH flag: 92]
    TCP payload (92 bytes)
Remote Procedure Call, Type:Call XID:0xd5c3ef35
    Fragment header: Last fragment, 88 bytes
        1... .... .... .... .... .... .... .... = Last Fragment: Yes
        .000 0000 0000 0000 0000 0000 0101 1000 = Fragment Length: 88
    XID: 0xd5c3ef35 (3586387765)
    Message Type: Call (0)
    RPC Version: 2
    Program: MOUNT (100005)
    Program Version: 3
    Procedure: EXPORT (5)
    [The reply to this request is in frame 174697]
    Credentials
        Flavor: AUTH_UNIX (1)
        Length: 48
        Stamp: 0x6913f911
        Machine Name: localhost.localdomain
            length: 21
            contents: localhost.localdomain
            fill bytes: opaque data
        UID: 0
        GID: 0
        Auxiliary GIDs (1) [0]
            GID: 0
    Verifier
        Flavor: AUTH_NULL (0)
        Length: 0
Mount Service
    [Program Version: 3]
    [V3 Procedure: EXPORT (5)]
```

# 174697	2025-11-12 11:03:45.426235	10.10.8.203	10.10.39.236	MOUNT	73	V3 EXPORT Reply (Call In 172640)	2050	934

```sh
Frame 174697: 73 bytes on wire (584 bits), 73 bytes captured (584 bits)
    Encapsulation type: Linux cooked-mode capture v1 (25)
    Arrival Time: Nov 12, 2025 11:03:45.426235000 中国标准时间
    UTC Arrival Time: Nov 12, 2025 03:03:45.426235000 UTC
    Epoch Arrival Time: 1762916625.426235000
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 0.000006000 seconds]
    [Time delta from previous displayed frame: 0.020132000 seconds]
    [Time since reference or first frame: 2.874072000 seconds]
    Frame Number: 174697
    Frame Length: 73 bytes (584 bits)
    Capture Length: 73 bytes (584 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:ethertype:vlan:ethertype:ip:tcp:rpc:mount]
    [Coloring Rule Name: TCP]
    [Coloring Rule String: tcp]
Linux cooked capture v1
    Packet type: Unicast to us (0)
    Link-layer address type: Ethernet (1)
    Link-layer address length: 6
    Source: HuaweiTechno_3c:d3:1e (20:0b:c7:3c:d3:1e)
    Unused: 0001
    Protocol: 802.1Q Virtual LAN (0x8100)
802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 2068
    000. .... .... .... = Priority: Best Effort (default) (0)
    ...0 .... .... .... = DEI: Ineligible
    .... 1000 0001 0100 = ID: 2068
    Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 10.10.8.203, Dst: 10.10.39.236
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 53
    Identification: 0xec18 (60440)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 63
    Protocol: TCP (6)
    Header Checksum: 0x0ae0 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 10.10.8.203
    Destination Address: 10.10.39.236
    [Stream index: 450]
Transmission Control Protocol, Src Port: 2050, Dst Port: 934, Seq: 14028, Ack: 93, Len: 1
    Source Port: 2050
    Destination Port: 934
    [Stream index: 2155]
    [Stream Packet Number: 28]
    [Conversation completeness: Complete, WITH_DATA (31)]
        ..0. .... = RST: Absent
        ...1 .... = FIN: Present
        .... 1... = Data: Present
        .... .1.. = ACK: Present
        .... ..1. = SYN-ACK: Present
        .... ...1 = SYN: Present
        [Completeness Flags: ·FDASS]
    [TCP Segment Len: 1]
    Sequence Number: 14028    (relative sequence number)
    Sequence Number (raw): 3990216173
    [Next Sequence Number: 14029    (relative sequence number)]
    Acknowledgment Number: 93    (relative ack number)
    Acknowledgment number (raw): 1876373145
    1000 .... = Header Length: 32 bytes (8)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 114
    [Calculated window size: 29184]
    [Window size scaling factor: 256]
    Checksum: 0xa527 [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - Timestamps: TSval 2639940410, TSecr 3835185478
            Kind: Time Stamp Option (8)
            Length: 10
            Timestamp value: 2639940410
            Timestamp echo reply: 3835185478
    [Timestamps]
        [Time since first frame in this TCP stream: 0.020284000 seconds]
        [Time since previous frame in this TCP stream: 0.000006000 seconds]
    [SEQ/ACK analysis]
        [iRTT: 0.000086000 seconds]
        [Bytes in flight: 1]
        [Bytes sent since last PSH flag: 42082]
    TCP payload (1 byte)
    TCP segment data (1 byte)
[7 Reassembled TCP Segments (14028 bytes): #174673(10136), #174688(3891), #174689(3891), #174690(3891), #174697(1), #174698(1), #174699(1)]
    [Frame: 174673, payload: 0-10135 (10136 bytes)]
    [Frame: 174688, payload: 10136-14026 (3891 bytes)]
    [Frame: 174689, payload: 10136-14026 (3891 bytes)]
        [Segment overlap: True]
    [Frame: 174690, payload: 10136-14026 (3891 bytes)]
        [Segment overlap: True]
    [Frame: 174697, payload: 14027-14027 (1 byte)]
    [Frame: 174698, payload: 14027-14027 (1 byte)]
        [Segment overlap: True]
    [Frame: 174699, payload: 14027-14027 (1 byte)]
        [Segment overlap: True]
    [Segment count: 7]
    [Reassembled TCP length: 14028]
    [Reassembled TCP Data […]: 800036c8d5c3ef35000000010000000000000000000000000000000000000001000000032f736300000000010000000d31302e31302e33392e302f3234000000000000010000000c31302e392e35302e302f32340000000000000001000000042f67796c00000001000]
Remote Procedure Call, Type:Reply XID:0xd5c3ef35
    Fragment header: Last fragment, 14024 bytes
        1... .... .... .... .... .... .... .... = Last Fragment: Yes
        .000 0000 0000 0000 0011 0110 1100 1000 = Fragment Length: 14024
    XID: 0xd5c3ef35 (3586387765)
    Message Type: Reply (1)
    [Program: MOUNT (100005)]
    [Program Version: 3]
    [Procedure: EXPORT (5)]
    Reply State: accepted (0)
    [This is a reply to a request in frame 172640]
    [Time from request: 0.020132000 seconds]
    Verifier
        Flavor: AUTH_NULL (0)
        Length: 0
    Accept State: RPC executed successfully (0)
Mount Service
    [Program Version: 3]
    [V3 Procedure: EXPORT (5)]
    Value Follows: Yes
    Export List Entry: /sc -> 10.10.39.0/24 10.9.50.0/24
        Directory: /sc
            length: 3
            contents: /sc
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.50.0/24
                length: 12
                contents: 10.9.50.0/24
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gyl -> 10.10.39.0/24
        Directory: /gyl
            length: 4
            contents: /gyl
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gj -> 10.10.39.0/24
        Directory: /gj
            length: 3
            contents: /gj
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /xm -> 10.10.39.0/24
        Directory: /xm
            length: 3
            contents: /xm
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /ggfw -> 10.10.39.0/24
        Directory: /ggfw
            length: 5
            contents: /ggfw
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /jksj -> 10.10.39.0/24
        Directory: /jksj
            length: 5
            contents: /jksj
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GYLXQ -> 10.10.39.0/24
        Directory: /GYLXQ
            length: 6
            contents: /GYLXQ
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc46_1 -> 10.92.215.113
        Directory: /aqjc46_1
            length: 9
            contents: /aqjc46_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.113
                length: 13
                contents: 10.92.215.113
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /S_NWCW_APP_11_14 -> 10.92.213.143 10.92.213.144 10.92.213.145 10.92.213.146
        Directory: /S_NWCW_APP_11_14
            length: 17
            contents: /S_NWCW_APP_11_14
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.213.143
                length: 13
                contents: 10.92.213.143
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.144
                length: 13
                contents: 10.92.213.144
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.145
                length: 13
                contents: 10.92.213.145
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.146
                length: 13
                contents: 10.92.213.146
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc47_1 -> 10.92.215.114
        Directory: /aqjc47_1
            length: 9
            contents: /aqjc47_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.114
                length: 13
                contents: 10.92.215.114
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc45_1 -> 10.92.215.112
        Directory: /aqjc45_1
            length: 9
            contents: /aqjc45_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.112
                length: 13
                contents: 10.92.215.112
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /S_NWCW_APP_1_4 -> 10.92.213.133 10.92.213.134 10.92.213.135 10.92.213.136 10.92.213.239 10.92.213.240
        Directory: /S_NWCW_APP_1_4
            length: 15
            contents: /S_NWCW_APP_1_4
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.213.133
                length: 13
                contents: 10.92.213.133
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.134
                length: 13
                contents: 10.92.213.134
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.135
                length: 13
                contents: 10.92.213.135
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.136
                length: 13
                contents: 10.92.213.136
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.239
                length: 13
                contents: 10.92.213.239
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.213.240
                length: 13
                contents: 10.92.213.240
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc44_1 -> 10.92.215.111
        Directory: /aqjc44_1
            length: 9
            contents: /aqjc44_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.111
                length: 13
                contents: 10.92.215.111
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /NYFZ_TSZJ_APP -> 10.92.221.169 10.92.221.170
        Directory: /NYFZ_TSZJ_APP
            length: 14
            contents: /NYFZ_TSZJ_APP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.221.169
                length: 13
                contents: 10.92.221.169
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.221.170
                length: 13
                contents: 10.92.221.170
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc43_1 -> 10.92.215.110
        Directory: /aqjc43_1
            length: 9
            contents: /aqjc43_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.110
                length: 13
                contents: 10.92.215.110
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc42_1 -> 10.92.215.109
        Directory: /aqjc42_1
            length: 9
            contents: /aqjc42_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.109
                length: 13
                contents: 10.92.215.109
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc41_1 -> 10.92.215.108
        Directory: /aqjc41_1
            length: 9
            contents: /aqjc41_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.108
                length: 13
                contents: 10.92.215.108
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc40_1 -> 10.92.215.107
        Directory: /aqjc40_1
            length: 9
            contents: /aqjc40_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.107
                length: 13
                contents: 10.92.215.107
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc39_1 -> 10.92.215.106
        Directory: /aqjc39_1
            length: 9
            contents: /aqjc39_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.106
                length: 13
                contents: 10.92.215.106
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc38_1 -> 10.92.215.105
        Directory: /aqjc38_1
            length: 9
            contents: /aqjc38_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.105
                length: 13
                contents: 10.92.215.105
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_MMWA_DB01_1 -> 10.10.39.188
        Directory: /GMP_MMWA_DB01_1
            length: 16
            contents: /GMP_MMWA_DB01_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.188
                length: 12
                contents: 10.10.39.188
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc27_1 -> 10.92.215.94
        Directory: /aqjc27_1
            length: 9
            contents: /aqjc27_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.94
                length: 12
                contents: 10.92.215.94
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /NYFZ_ECP_APP -> 10.92.221.241 10.92.221.242
        Directory: /NYFZ_ECP_APP
            length: 13
            contents: /NYFZ_ECP_APP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.221.241
                length: 13
                contents: 10.92.221.241
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.221.242
                length: 13
                contents: 10.92.221.242
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPRE_DB02_1 -> 10.10.39.205
        Directory: /GMP_SPRE_DB02_1
            length: 16
            contents: /GMP_SPRE_DB02_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.205
                length: 12
                contents: 10.10.39.205
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc26_1 -> 10.92.215.93
        Directory: /aqjc26_1
            length: 9
            contents: /aqjc26_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.93
                length: 12
                contents: 10.92.215.93
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /WZCW_ECP -> 10.92.221.211 10.92.221.212
        Directory: /WZCW_ECP
            length: 9
            contents: /WZCW_ECP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.221.211
                length: 13
                contents: 10.92.221.211
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.221.212
                length: 13
                contents: 10.92.221.212
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc25_1 -> 10.92.215.92
        Directory: /aqjc25_1
            length: 9
            contents: /aqjc25_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.92
                length: 12
                contents: 10.92.215.92
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /S_DXCW_BPM -> 10.92.220.150 10.92.220.151
        Directory: /S_DXCW_BPM
            length: 11
            contents: /S_DXCW_BPM
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.220.150
                length: 13
                contents: 10.92.220.150
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.220.151
                length: 13
                contents: 10.92.220.151
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc24_1 -> 10.92.215.91
        Directory: /aqjc24_1
            length: 9
            contents: /aqjc24_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.91
                length: 12
                contents: 10.92.215.91
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc23_1 -> 10.92.215.90
        Directory: /aqjc23_1
            length: 9
            contents: /aqjc23_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.90
                length: 12
                contents: 10.92.215.90
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc22_1 -> 10.92.215.89
        Directory: /aqjc22_1
            length: 9
            contents: /aqjc22_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.89
                length: 12
                contents: 10.92.215.89
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc21_1 -> 10.92.215.88
        Directory: /aqjc21_1
            length: 9
            contents: /aqjc21_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.88
                length: 12
                contents: 10.92.215.88
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc20_1 -> 10.92.215.87
        Directory: /aqjc20_1
            length: 9
            contents: /aqjc20_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.87
                length: 12
                contents: 10.92.215.87
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc19_1 -> 10.92.215.86
        Directory: /aqjc19_1
            length: 9
            contents: /aqjc19_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.86
                length: 12
                contents: 10.92.215.86
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /aqjc18_1 -> 10.92.215.85
        Directory: /aqjc18_1
            length: 9
            contents: /aqjc18_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.215.85
                length: 12
                contents: 10.92.215.85
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPSAFE_DB02_1 -> 10.10.39.197
        Directory: /GMP_SPSAFE_DB02_1
            length: 18
            contents: /GMP_SPSAFE_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.197
                length: 12
                contents: 10.10.39.197
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /CYTZ_CWGL_ECPAPP -> 10.92.185.169 10.92.185.170
        Directory: /CYTZ_CWGL_ECPAPP
            length: 17
            contents: /CYTZ_CWGL_ECPAPP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.185.169
                length: 13
                contents: 10.92.185.169
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.185.170
                length: 13
                contents: 10.92.185.170
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /SYYTSZJCW_APP -> 10.92.185.96 10.92.185.97
        Directory: /SYYTSZJCW_APP
            length: 14
            contents: /SYYTSZJCW_APP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.185.96
                length: 12
                contents: 10.92.185.96
            Value Follows: Yes
            Group: 10.92.185.97
                length: 12
                contents: 10.92.185.97
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /CYTZ_TSZJ_APP_1 -> 10.92.185.189 10.92.185.190
        Directory: /CYTZ_TSZJ_APP_1
            length: 16
            contents: /CYTZ_TSZJ_APP_1
        Groups
            Value Follows: Yes
            Group: 10.92.185.189
                length: 13
                contents: 10.92.185.189
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.185.190
                length: 13
                contents: 10.92.185.190
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPEQPQ_DB02_1 -> 10.10.39.193
        Directory: /GMP_SPEQPQ_DB02_1
            length: 18
            contents: /GMP_SPEQPQ_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.193
                length: 12
                contents: 10.10.39.193
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /DYZC_TSZJ_APP -> 10.92.187.196 10.92.185.145
        Directory: /DYZC_TSZJ_APP
            length: 14
            contents: /DYZC_TSZJ_APP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.187.196
                length: 13
                contents: 10.92.187.196
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.185.145
                length: 13
                contents: 10.92.185.145
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_MMRE_DB01_1 -> 10.10.39.224 10.10.39.225 10.10.39.186
        Directory: /GMP_MMRE_DB01_1
            length: 16
            contents: /GMP_MMRE_DB01_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.224
                length: 12
                contents: 10.10.39.224
            Value Follows: Yes
            Group: 10.10.39.225
                length: 12
                contents: 10.10.39.225
            Value Follows: Yes
            Group: 10.10.39.186
                length: 12
                contents: 10.10.39.186
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /ZBKG_APP -> 10.92.220.139 10.92.220.140
        Directory: /ZBKG_APP
            length: 9
            contents: /ZBKG_APP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.220.139
                length: 13
                contents: 10.92.220.139
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.220.140
                length: 13
                contents: 10.92.220.140
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_MMRE_DB02_1 -> 10.10.39.187
        Directory: /GMP_MMRE_DB02_1
            length: 16
            contents: /GMP_MMRE_DB02_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.187
                length: 12
                contents: 10.10.39.187
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GJCW_ECP_APP -> 10.92.220.173 10.92.220.174
        Directory: /GJCW_ECP_APP
            length: 13
            contents: /GJCW_ECP_APP
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.220.173
                length: 13
                contents: 10.92.220.173
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.92.220.174
                length: 13
                contents: 10.92.220.174
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPRE_DB01_1 -> 10.10.39.204
        Directory: /GMP_SPRE_DB01_1
            length: 16
            contents: /GMP_SPRE_DB01_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.204
                length: 12
                contents: 10.10.39.204
            Value Follows: No
    Value Follows: Yes
     […]Export List Entry: /RLZY_APP_1 -> 10.10.29.134 10.10.29.137 10.10.29.141 10.10.29.143 10.10.29.144 10.10.29.145 10.10.29.146 10.10.29.147 10.10.29.148 10.10.29.150 10.10.29.151 10.10.29.152 10.10.29.153 10.10.29.154 10.10.29.155 10.1
        Directory: /RLZY_APP_1
            length: 11
            contents: /RLZY_APP_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.29.134
                length: 12
                contents: 10.10.29.134
            Value Follows: Yes
            Group: 10.10.29.137
                length: 12
                contents: 10.10.29.137
            Value Follows: Yes
            Group: 10.10.29.141
                length: 12
                contents: 10.10.29.141
            Value Follows: Yes
            Group: 10.10.29.143
                length: 12
                contents: 10.10.29.143
            Value Follows: Yes
            Group: 10.10.29.144
                length: 12
                contents: 10.10.29.144
            Value Follows: Yes
            Group: 10.10.29.145
                length: 12
                contents: 10.10.29.145
            Value Follows: Yes
            Group: 10.10.29.146
                length: 12
                contents: 10.10.29.146
            Value Follows: Yes
            Group: 10.10.29.147
                length: 12
                contents: 10.10.29.147
            Value Follows: Yes
            Group: 10.10.29.148
                length: 12
                contents: 10.10.29.148
            Value Follows: Yes
            Group: 10.10.29.150
                length: 12
                contents: 10.10.29.150
            Value Follows: Yes
            Group: 10.10.29.151
                length: 12
                contents: 10.10.29.151
            Value Follows: Yes
            Group: 10.10.29.152
                length: 12
                contents: 10.10.29.152
            Value Follows: Yes
            Group: 10.10.29.153
                length: 12
                contents: 10.10.29.153
            Value Follows: Yes
            Group: 10.10.29.154
                length: 12
                contents: 10.10.29.154
            Value Follows: Yes
            Group: 10.10.29.155
                length: 12
                contents: 10.10.29.155
            Value Follows: Yes
            Group: 10.10.29.156
                length: 12
                contents: 10.10.29.156
            Value Follows: Yes
            Group: 10.10.29.157
                length: 12
                contents: 10.10.29.157
            Value Follows: Yes
            Group: 10.10.29.158
                length: 12
                contents: 10.10.29.158
            Value Follows: Yes
            Group: 10.10.29.165
                length: 12
                contents: 10.10.29.165
            Value Follows: Yes
            Group: 10.10.29.180
                length: 12
                contents: 10.10.29.180
            Value Follows: Yes
            Group: 10.10.29.159
                length: 12
                contents: 10.10.29.159
            Value Follows: Yes
            Group: 10.10.29.169
                length: 12
                contents: 10.10.29.169
            Value Follows: Yes
            Group: 10.10.29.178
                length: 12
                contents: 10.10.29.178
            Value Follows: Yes
            Group: 10.10.29.179
                length: 12
                contents: 10.10.29.179
            Value Follows: Yes
            Group: 10.10.29.181
                length: 12
                contents: 10.10.29.181
            Value Follows: Yes
            Group: 10.10.29.149
                length: 12
                contents: 10.10.29.149
            Value Follows: Yes
            Group: 10.10.29.182
                length: 12
                contents: 10.10.29.182
            Value Follows: Yes
            Group: 10.10.29.140
                length: 12
                contents: 10.10.29.140
            Value Follows: Yes
            Group: 10.10.29.142
                length: 12
                contents: 10.10.29.142
            Value Follows: Yes
            Group: 10.10.29.160
                length: 12
                contents: 10.10.29.160
            Value Follows: Yes
            Group: 10.10.29.161
                length: 12
                contents: 10.10.29.161
            Value Follows: Yes
            Group: 10.10.29.162
                length: 12
                contents: 10.10.29.162
            Value Follows: Yes
            Group: 10.10.29.163
                length: 12
                contents: 10.10.29.163
            Value Follows: Yes
            Group: 10.10.29.164
                length: 12
                contents: 10.10.29.164
            Value Follows: Yes
            Group: 10.10.29.168
                length: 12
                contents: 10.10.29.168
            Value Follows: Yes
            Group: 10.10.29.170
                length: 12
                contents: 10.10.29.170
            Value Follows: Yes
            Group: 10.10.29.171
                length: 12
                contents: 10.10.29.171
            Value Follows: Yes
            Group: 10.10.29.172
                length: 12
                contents: 10.10.29.172
            Value Follows: Yes
            Group: 10.10.29.173
                length: 12
                contents: 10.10.29.173
            Value Follows: Yes
            Group: 10.10.86.141
                length: 12
                contents: 10.10.86.141
            Value Follows: Yes
            Group: 10.10.86.142
                length: 12
                contents: 10.10.86.142
            Value Follows: Yes
            Group: 10.10.86.143
                length: 12
                contents: 10.10.86.143
            Value Follows: Yes
            Group: 10.10.86.144
                length: 12
                contents: 10.10.86.144
            Value Follows: Yes
            Group: 10.10.86.145
                length: 12
                contents: 10.10.86.145
            Value Follows: Yes
            Group: 10.10.87.120
                length: 12
                contents: 10.10.87.120
            Value Follows: Yes
            Group: 10.10.87.121
                length: 12
                contents: 10.10.87.121
            Value Follows: Yes
            Group: 10.10.87.122
                length: 12
                contents: 10.10.87.122
            Value Follows: Yes
            Group: 10.10.87.123
                length: 12
                contents: 10.10.87.123
            Value Follows: Yes
            Group: 10.10.87.124
                length: 12
                contents: 10.10.87.124
            Value Follows: Yes
            Group: 10.10.87.125
                length: 12
                contents: 10.10.87.125
            Value Follows: Yes
            Group: 10.10.87.126
                length: 12
                contents: 10.10.87.126
            Value Follows: Yes
            Group: 10.10.87.127
                length: 12
                contents: 10.10.87.127
            Value Follows: Yes
            Group: 10.10.87.128
                length: 12
                contents: 10.10.87.128
            Value Follows: Yes
            Group: 10.10.87.129
                length: 12
                contents: 10.10.87.129
            Value Follows: Yes
            Group: 10.10.87.130
                length: 12
                contents: 10.10.87.130
            Value Follows: Yes
            Group: 10.10.87.131
                length: 12
                contents: 10.10.87.131
            Value Follows: Yes
            Group: 10.10.87.132
                length: 12
                contents: 10.10.87.132
            Value Follows: Yes
            Group: 10.10.87.133
                length: 12
                contents: 10.10.87.133
            Value Follows: Yes
            Group: 10.10.87.134
                length: 12
                contents: 10.10.87.134
            Value Follows: Yes
            Group: 10.10.6.87
                length: 10
                contents: 10.10.6.87
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.88
                length: 10
                contents: 10.10.6.88
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.89
                length: 10
                contents: 10.10.6.89
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.90
                length: 10
                contents: 10.10.6.90
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.91
                length: 10
                contents: 10.10.6.91
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.92
                length: 10
                contents: 10.10.6.92
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.93
                length: 10
                contents: 10.10.6.93
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.94
                length: 10
                contents: 10.10.6.94
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.95
                length: 10
                contents: 10.10.6.95
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
     […]Export List Entry: /RLZY_APP_2 -> 10.10.29.134 10.10.29.137 10.10.29.141 10.10.29.165 10.10.29.143 10.10.29.144 10.10.29.145 10.10.29.146 10.10.29.147 10.10.29.148 10.10.29.150 10.10.29.151 10.10.29.152 10.10.29.153 10.10.29.154 10.1
        Directory: /RLZY_APP_2
            length: 11
            contents: /RLZY_APP_2
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.29.134
                length: 12
                contents: 10.10.29.134
            Value Follows: Yes
            Group: 10.10.29.137
                length: 12
                contents: 10.10.29.137
            Value Follows: Yes
            Group: 10.10.29.141
                length: 12
                contents: 10.10.29.141
            Value Follows: Yes
            Group: 10.10.29.165
                length: 12
                contents: 10.10.29.165
            Value Follows: Yes
            Group: 10.10.29.143
                length: 12
                contents: 10.10.29.143
            Value Follows: Yes
            Group: 10.10.29.144
                length: 12
                contents: 10.10.29.144
            Value Follows: Yes
            Group: 10.10.29.145
                length: 12
                contents: 10.10.29.145
            Value Follows: Yes
            Group: 10.10.29.146
                length: 12
                contents: 10.10.29.146
            Value Follows: Yes
            Group: 10.10.29.147
                length: 12
                contents: 10.10.29.147
            Value Follows: Yes
            Group: 10.10.29.148
                length: 12
                contents: 10.10.29.148
            Value Follows: Yes
            Group: 10.10.29.150
                length: 12
                contents: 10.10.29.150
            Value Follows: Yes
            Group: 10.10.29.151
                length: 12
                contents: 10.10.29.151
            Value Follows: Yes
            Group: 10.10.29.152
                length: 12
                contents: 10.10.29.152
            Value Follows: Yes
            Group: 10.10.29.153
                length: 12
                contents: 10.10.29.153
            Value Follows: Yes
            Group: 10.10.29.154
                length: 12
                contents: 10.10.29.154
            Value Follows: Yes
            Group: 10.10.29.155
                length: 12
                contents: 10.10.29.155
            Value Follows: Yes
            Group: 10.10.29.156
                length: 12
                contents: 10.10.29.156
            Value Follows: Yes
            Group: 10.10.29.157
                length: 12
                contents: 10.10.29.157
            Value Follows: Yes
            Group: 10.10.29.158
                length: 12
                contents: 10.10.29.158
            Value Follows: Yes
            Group: 10.10.29.180
                length: 12
                contents: 10.10.29.180
            Value Follows: Yes
            Group: 10.10.29.159
                length: 12
                contents: 10.10.29.159
            Value Follows: Yes
            Group: 10.10.29.169
                length: 12
                contents: 10.10.29.169
            Value Follows: Yes
            Group: 10.10.29.178
                length: 12
                contents: 10.10.29.178
            Value Follows: Yes
            Group: 10.10.29.179
                length: 12
                contents: 10.10.29.179
            Value Follows: Yes
            Group: 10.10.29.181
                length: 12
                contents: 10.10.29.181
            Value Follows: Yes
            Group: 10.10.29.149
                length: 12
                contents: 10.10.29.149
            Value Follows: Yes
            Group: 10.10.29.182
                length: 12
                contents: 10.10.29.182
            Value Follows: Yes
            Group: 10.10.29.140
                length: 12
                contents: 10.10.29.140
            Value Follows: Yes
            Group: 10.10.29.142
                length: 12
                contents: 10.10.29.142
            Value Follows: Yes
            Group: 10.10.29.160
                length: 12
                contents: 10.10.29.160
            Value Follows: Yes
            Group: 10.10.29.161
                length: 12
                contents: 10.10.29.161
            Value Follows: Yes
            Group: 10.10.29.162
                length: 12
                contents: 10.10.29.162
            Value Follows: Yes
            Group: 10.10.29.163
                length: 12
                contents: 10.10.29.163
            Value Follows: Yes
            Group: 10.10.29.164
                length: 12
                contents: 10.10.29.164
            Value Follows: Yes
            Group: 10.10.29.168
                length: 12
                contents: 10.10.29.168
            Value Follows: Yes
            Group: 10.10.29.170
                length: 12
                contents: 10.10.29.170
            Value Follows: Yes
            Group: 10.10.29.171
                length: 12
                contents: 10.10.29.171
            Value Follows: Yes
            Group: 10.10.29.172
                length: 12
                contents: 10.10.29.172
            Value Follows: Yes
            Group: 10.10.29.173
                length: 12
                contents: 10.10.29.173
            Value Follows: Yes
            Group: 10.10.86.141
                length: 12
                contents: 10.10.86.141
            Value Follows: Yes
            Group: 10.10.86.142
                length: 12
                contents: 10.10.86.142
            Value Follows: Yes
            Group: 10.10.86.143
                length: 12
                contents: 10.10.86.143
            Value Follows: Yes
            Group: 10.10.86.144
                length: 12
                contents: 10.10.86.144
            Value Follows: Yes
            Group: 10.10.86.145
                length: 12
                contents: 10.10.86.145
            Value Follows: Yes
            Group: 10.10.87.120
                length: 12
                contents: 10.10.87.120
            Value Follows: Yes
            Group: 10.10.87.121
                length: 12
                contents: 10.10.87.121
            Value Follows: Yes
            Group: 10.10.87.122
                length: 12
                contents: 10.10.87.122
            Value Follows: Yes
            Group: 10.10.87.123
                length: 12
                contents: 10.10.87.123
            Value Follows: Yes
            Group: 10.10.87.124
                length: 12
                contents: 10.10.87.124
            Value Follows: Yes
            Group: 10.10.87.125
                length: 12
                contents: 10.10.87.125
            Value Follows: Yes
            Group: 10.10.87.126
                length: 12
                contents: 10.10.87.126
            Value Follows: Yes
            Group: 10.10.87.127
                length: 12
                contents: 10.10.87.127
            Value Follows: Yes
            Group: 10.10.87.128
                length: 12
                contents: 10.10.87.128
            Value Follows: Yes
            Group: 10.10.87.129
                length: 12
                contents: 10.10.87.129
            Value Follows: Yes
            Group: 10.10.87.130
                length: 12
                contents: 10.10.87.130
            Value Follows: Yes
            Group: 10.10.87.131
                length: 12
                contents: 10.10.87.131
            Value Follows: Yes
            Group: 10.10.87.132
                length: 12
                contents: 10.10.87.132
            Value Follows: Yes
            Group: 10.10.87.133
                length: 12
                contents: 10.10.87.133
            Value Follows: Yes
            Group: 10.10.87.134
                length: 12
                contents: 10.10.87.134
            Value Follows: Yes
            Group: 10.10.6.87
                length: 10
                contents: 10.10.6.87
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.88
                length: 10
                contents: 10.10.6.88
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.89
                length: 10
                contents: 10.10.6.89
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.90
                length: 10
                contents: 10.10.6.90
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.91
                length: 10
                contents: 10.10.6.91
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.92
                length: 10
                contents: 10.10.6.92
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.93
                length: 10
                contents: 10.10.6.93
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.94
                length: 10
                contents: 10.10.6.94
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.6.95
                length: 10
                contents: 10.10.6.95
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /lcam -> 10.92.210.66
        Directory: /lcam
            length: 5
            contents: /lcam
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.92.210.66
                length: 12
                contents: 10.92.210.66
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_sppc_db01_1 -> 10.10.39.174
        Directory: /gmp_sppc_db01_1
            length: 16
            contents: /gmp_sppc_db01_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.174
                length: 12
                contents: 10.10.39.174
            Value Follows: No
    Value Follows: Yes
     […]Export List Entry: /GMP_FMS_1 -> 10.10.38.10 10.10.38.11 10.10.38.12 10.10.38.13 10.10.38.14 10.10.38.15 10.10.38.16 10.10.38.17 10.10.38.18 10.10.38.19 10.10.38.20 10.10.38.23 10.10.38.24 10.10.38.29 10.10.38.31 10.10.38.32 10.10.38
        Directory: /GMP_FMS_1
            length: 10
            contents: /GMP_FMS_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.38.10
                length: 11
                contents: 10.10.38.10
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.11
                length: 11
                contents: 10.10.38.11
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.12
                length: 11
                contents: 10.10.38.12
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.13
                length: 11
                contents: 10.10.38.13
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.14
                length: 11
                contents: 10.10.38.14
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.15
                length: 11
                contents: 10.10.38.15
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.16
                length: 11
                contents: 10.10.38.16
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.17
                length: 11
                contents: 10.10.38.17
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.18
                length: 11
                contents: 10.10.38.18
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.19
                length: 11
                contents: 10.10.38.19
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.20
                length: 11
                contents: 10.10.38.20
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.23
                length: 11
                contents: 10.10.38.23
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.24
                length: 11
                contents: 10.10.38.24
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.29
                length: 11
                contents: 10.10.38.29
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.31
                length: 11
                contents: 10.10.38.31
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.32
                length: 11
                contents: 10.10.38.32
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.33
                length: 11
                contents: 10.10.38.33
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.34
                length: 11
                contents: 10.10.38.34
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.35
                length: 11
                contents: 10.10.38.35
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.36
                length: 11
                contents: 10.10.38.36
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.37
                length: 11
                contents: 10.10.38.37
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.38
                length: 11
                contents: 10.10.38.38
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.40
                length: 11
                contents: 10.10.38.40
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.41
                length: 11
                contents: 10.10.38.41
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.42
                length: 11
                contents: 10.10.38.42
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.43
                length: 11
                contents: 10.10.38.43
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.44
                length: 11
                contents: 10.10.38.44
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.45
                length: 11
                contents: 10.10.38.45
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.46
                length: 11
                contents: 10.10.38.46
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.47
                length: 11
                contents: 10.10.38.47
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.3
                length: 10
                contents: 10.10.38.3
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.4
                length: 10
                contents: 10.10.38.4
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.5
                length: 10
                contents: 10.10.38.5
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.6
                length: 10
                contents: 10.10.38.6
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.7
                length: 10
                contents: 10.10.38.7
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.8
                length: 10
                contents: 10.10.38.8
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.9
                length: 10
                contents: 10.10.38.9
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.50
                length: 11
                contents: 10.10.38.50
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.51
                length: 11
                contents: 10.10.38.51
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.52
                length: 11
                contents: 10.10.38.52
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.53
                length: 11
                contents: 10.10.38.53
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.54
                length: 11
                contents: 10.10.38.54
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.55
                length: 11
                contents: 10.10.38.55
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.57
                length: 11
                contents: 10.10.38.57
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.86
                length: 11
                contents: 10.10.38.86
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.87
                length: 11
                contents: 10.10.38.87
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.88
                length: 11
                contents: 10.10.38.88
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.89
                length: 11
                contents: 10.10.38.89
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.90
                length: 11
                contents: 10.10.38.90
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.91
                length: 11
                contents: 10.10.38.91
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.100
                length: 12
                contents: 10.10.38.100
            Value Follows: Yes
            Group: 10.10.38.101
                length: 12
                contents: 10.10.38.101
            Value Follows: Yes
            Group: 10.10.38.102
                length: 12
                contents: 10.10.38.102
            Value Follows: Yes
            Group: 10.10.38.103
                length: 12
                contents: 10.10.38.103
            Value Follows: Yes
            Group: 10.10.38.104
                length: 12
                contents: 10.10.38.104
            Value Follows: Yes
            Group: 10.10.38.105
                length: 12
                contents: 10.10.38.105
            Value Follows: Yes
            Group: 10.10.38.106
                length: 12
                contents: 10.10.38.106
            Value Follows: Yes
            Group: 10.10.38.107
                length: 12
                contents: 10.10.38.107
            Value Follows: Yes
            Group: 10.10.38.108
                length: 12
                contents: 10.10.38.108
            Value Follows: Yes
            Group: 10.10.38.109
                length: 12
                contents: 10.10.38.109
            Value Follows: Yes
            Group: 10.10.38.110
                length: 12
                contents: 10.10.38.110
            Value Follows: Yes
            Group: 10.10.38.111
                length: 12
                contents: 10.10.38.111
            Value Follows: Yes
            Group: 10.10.38.112
                length: 12
                contents: 10.10.38.112
            Value Follows: Yes
            Group: 10.10.38.113
                length: 12
                contents: 10.10.38.113
            Value Follows: Yes
            Group: 10.10.38.114
                length: 12
                contents: 10.10.38.114
            Value Follows: Yes
            Group: 10.10.38.115
                length: 12
                contents: 10.10.38.115
            Value Follows: Yes
            Group: 10.10.38.116
                length: 12
                contents: 10.10.38.116
            Value Follows: Yes
            Group: 10.10.38.117
                length: 12
                contents: 10.10.38.117
            Value Follows: Yes
            Group: 10.10.38.118
                length: 12
                contents: 10.10.38.118
            Value Follows: Yes
            Group: 10.10.38.119
                length: 12
                contents: 10.10.38.119
            Value Follows: Yes
            Group: 10.10.38.120
                length: 12
                contents: 10.10.38.120
            Value Follows: Yes
            Group: 10.10.38.121
                length: 12
                contents: 10.10.38.121
            Value Follows: Yes
            Group: 10.10.38.122
                length: 12
                contents: 10.10.38.122
            Value Follows: Yes
            Group: 10.10.38.123
                length: 12
                contents: 10.10.38.123
            Value Follows: Yes
            Group: 10.10.38.124
                length: 12
                contents: 10.10.38.124
            Value Follows: Yes
            Group: 10.10.38.125
                length: 12
                contents: 10.10.38.125
            Value Follows: Yes
            Group: 10.10.38.126
                length: 12
                contents: 10.10.38.126
            Value Follows: Yes
            Group: 10.10.38.127
                length: 12
                contents: 10.10.38.127
            Value Follows: Yes
            Group: 10.10.38.128
                length: 12
                contents: 10.10.38.128
            Value Follows: Yes
            Group: 10.10.38.129
                length: 12
                contents: 10.10.38.129
            Value Follows: Yes
            Group: 10.10.38.130
                length: 12
                contents: 10.10.38.130
            Value Follows: Yes
            Group: 10.10.38.131
                length: 12
                contents: 10.10.38.131
            Value Follows: Yes
            Group: 10.10.38.132
                length: 12
                contents: 10.10.38.132
            Value Follows: Yes
            Group: 10.10.38.133
                length: 12
                contents: 10.10.38.133
            Value Follows: Yes
            Group: 10.10.38.134
                length: 12
                contents: 10.10.38.134
            Value Follows: Yes
            Group: 10.10.38.135
                length: 12
                contents: 10.10.38.135
            Value Follows: Yes
            Group: 10.10.38.136
                length: 12
                contents: 10.10.38.136
            Value Follows: Yes
            Group: 10.10.38.137
                length: 12
                contents: 10.10.38.137
            Value Follows: Yes
            Group: 10.10.38.138
                length: 12
                contents: 10.10.38.138
            Value Follows: Yes
            Group: 10.10.38.145
                length: 12
                contents: 10.10.38.145
            Value Follows: Yes
            Group: 10.10.38.146
                length: 12
                contents: 10.10.38.146
            Value Follows: Yes
            Group: 10.10.38.147
                length: 12
                contents: 10.10.38.147
            Value Follows: Yes
            Group: 10.10.38.148
                length: 12
                contents: 10.10.38.148
            Value Follows: Yes
            Group: 10.10.38.149
                length: 12
                contents: 10.10.38.149
            Value Follows: Yes
            Group: 10.10.38.150
                length: 12
                contents: 10.10.38.150
            Value Follows: Yes
            Group: 10.10.38.151
                length: 12
                contents: 10.10.38.151
            Value Follows: Yes
            Group: 10.10.38.152
                length: 12
                contents: 10.10.38.152
            Value Follows: Yes
            Group: 10.10.38.153
                length: 12
                contents: 10.10.38.153
            Value Follows: Yes
            Group: 10.10.38.154
                length: 12
                contents: 10.10.38.154
            Value Follows: Yes
            Group: 10.10.38.155
                length: 12
                contents: 10.10.38.155
            Value Follows: Yes
            Group: 10.10.38.156
                length: 12
                contents: 10.10.38.156
            Value Follows: Yes
            Group: 10.10.38.157
                length: 12
                contents: 10.10.38.157
            Value Follows: Yes
            Group: 10.10.38.158
                length: 12
                contents: 10.10.38.158
            Value Follows: Yes
            Group: 10.10.38.159
                length: 12
                contents: 10.10.38.159
            Value Follows: Yes
            Group: 10.10.38.160
                length: 12
                contents: 10.10.38.160
            Value Follows: Yes
            Group: 10.10.38.92
                length: 11
                contents: 10.10.38.92
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.93
                length: 11
                contents: 10.10.38.93
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.60
                length: 11
                contents: 10.10.38.60
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.61
                length: 11
                contents: 10.10.38.61
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.62
                length: 11
                contents: 10.10.38.62
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.63
                length: 11
                contents: 10.10.38.63
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.64
                length: 11
                contents: 10.10.38.64
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.65
                length: 11
                contents: 10.10.38.65
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.66
                length: 11
                contents: 10.10.38.66
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.67
                length: 11
                contents: 10.10.38.67
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.68
                length: 11
                contents: 10.10.38.68
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.69
                length: 11
                contents: 10.10.38.69
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.70
                length: 11
                contents: 10.10.38.70
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.71
                length: 11
                contents: 10.10.38.71
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.72
                length: 11
                contents: 10.10.38.72
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.73
                length: 11
                contents: 10.10.38.73
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.74
                length: 11
                contents: 10.10.38.74
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.75
                length: 11
                contents: 10.10.38.75
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.76
                length: 11
                contents: 10.10.38.76
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.77
                length: 11
                contents: 10.10.38.77
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.78
                length: 11
                contents: 10.10.38.78
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.79
                length: 11
                contents: 10.10.38.79
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.83
                length: 11
                contents: 10.10.38.83
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.38.190
                length: 12
                contents: 10.10.38.190
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /VS_RLZYGLYH_DMDB_03_1 -> 10.10.33.145 10.10.29.183
        Directory: /VS_RLZYGLYH_DMDB_03_1
            length: 22
            contents: /VS_RLZYGLYH_DMDB_03_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.33.145
                length: 12
                contents: 10.10.33.145
            Value Follows: Yes
            Group: 10.10.29.183
                length: 12
                contents: 10.10.29.183
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /VS_RLZYGLYH_DMDB_04_1 -> 10.10.33.146 10.10.29.184
        Directory: /VS_RLZYGLYH_DMDB_04_1
            length: 22
            contents: /VS_RLZYGLYH_DMDB_04_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.33.146
                length: 12
                contents: 10.10.33.146
            Value Follows: Yes
            Group: 10.10.29.184
                length: 12
                contents: 10.10.29.184
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMPHR_220_1 -> 10.10.33.220
        Directory: /GMPHR_220_1
            length: 12
            contents: /GMPHR_220_1
        Groups
            Value Follows: Yes
            Group: 10.10.33.220
                length: 12
                contents: 10.10.33.220
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMPHR_221_1 -> 10.10.33.221
        Directory: /GMPHR_221_1
            length: 12
            contents: /GMPHR_221_1
        Groups
            Value Follows: Yes
            Group: 10.10.33.221
                length: 12
                contents: 10.10.33.221
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_mmcont_db01_1 -> 10.10.39.206
        Directory: /gmp_mmcont_db01_1
            length: 18
            contents: /gmp_mmcont_db01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.206
                length: 12
                contents: 10.10.39.206
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_mmcont_db02_1 -> 10.10.39.207
        Directory: /gmp_mmcont_db02_1
            length: 18
            contents: /gmp_mmcont_db02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.207
                length: 12
                contents: 10.10.39.207
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPOPER_DB01_1 -> 10.10.39.190
        Directory: /GMP_SPOPER_DB01_1
            length: 18
            contents: /GMP_SPOPER_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.190
                length: 12
                contents: 10.10.39.190
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPOPER_DB02_1 -> 10.10.39.191
        Directory: /GMP_SPOPER_DB02_1
            length: 18
            contents: /GMP_SPOPER_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.191
                length: 12
                contents: 10.10.39.191
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPEQPM_DB01_1 -> 10.10.39.198
        Directory: /GMP_SPEQPM_DB01_1
            length: 18
            contents: /GMP_SPEQPM_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.198
                length: 12
                contents: 10.10.39.198
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPEQPM_DB02_1 -> 10.10.39.199
        Directory: /GMP_SPEQPM_DB02_1
            length: 18
            contents: /GMP_SPEQPM_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.199
                length: 12
                contents: 10.10.39.199
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPSAFE_DB01_1 -> 10.10.39.196
        Directory: /GMP_SPSAFE_DB01_1
            length: 18
            contents: /GMP_SPSAFE_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.196
                length: 12
                contents: 10.10.39.196
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPDISP_DB01_1 -> 10.10.39.194
        Directory: /GMP_SPDISP_DB01_1
            length: 18
            contents: /GMP_SPDISP_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.194
                length: 12
                contents: 10.10.39.194
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPDISP_DB02_1 -> 10.10.39.195
        Directory: /GMP_SPDISP_DB02_1
            length: 18
            contents: /GMP_SPDISP_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.195
                length: 12
                contents: 10.10.39.195
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPEMER_DB01_1 -> 10.10.39.200
        Directory: /GMP_SPEMER_DB01_1
            length: 18
            contents: /GMP_SPEMER_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.200
                length: 12
                contents: 10.10.39.200
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPEMER_DB02_1 -> 10.10.39.201
        Directory: /GMP_SPEMER_DB02_1
            length: 18
            contents: /GMP_SPEMER_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.201
                length: 12
                contents: 10.10.39.201
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPEQPQ_DB01_1 -> 10.10.39.192
        Directory: /GMP_SPEQPQ_DB01_1
            length: 18
            contents: /GMP_SPEQPQ_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.192
                length: 12
                contents: 10.10.39.192
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_MMWA_DB02_1 -> 10.10.39.189
        Directory: /GMP_MMWA_DB02_1
            length: 16
            contents: /GMP_MMWA_DB02_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.189
                length: 12
                contents: 10.10.39.189
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PCINP_DB01_1 -> 10.10.39.180
        Directory: /GMP_PCINP_DB01_1
            length: 17
            contents: /GMP_PCINP_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.180
                length: 12
                contents: 10.10.39.180
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PCINP_DB02_1 -> 10.10.39.181
        Directory: /GMP_PCINP_DB02_1
            length: 17
            contents: /GMP_PCINP_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.181
                length: 12
                contents: 10.10.39.181
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PCINPCO_DB01_1 -> 10.10.39.182
        Directory: /GMP_PCINPCO_DB01_1
            length: 19
            contents: /GMP_PCINPCO_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.182
                length: 12
                contents: 10.10.39.182
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PCINPCO_DB02_1 -> 10.10.39.183
        Directory: /GMP_PCINPCO_DB02_1
            length: 19
            contents: /GMP_PCINPCO_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.183
                length: 12
                contents: 10.10.39.183
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PMS_DB01_1 -> 10.10.39.184
        Directory: /GMP_PMS_DB01_1
            length: 15
            contents: /GMP_PMS_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.184
                length: 12
                contents: 10.10.39.184
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PMS_DB02_1 -> 10.10.39.185
        Directory: /GMP_PMS_DB02_1
            length: 15
            contents: /GMP_PMS_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.185
                length: 12
                contents: 10.10.39.185
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPS_DB01_1 -> 10.10.39.176
        Directory: /GMP_SPS_DB01_1
            length: 15
            contents: /GMP_SPS_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.176
                length: 12
                contents: 10.10.39.176
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPS_DB02_1 -> 10.10.39.177
        Directory: /GMP_SPS_DB02_1
            length: 15
            contents: /GMP_SPS_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.177
                length: 12
                contents: 10.10.39.177
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PCIP_DB01_1 -> 10.10.39.178
        Directory: /GMP_PCIP_DB01_1
            length: 16
            contents: /GMP_PCIP_DB01_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.178
                length: 12
                contents: 10.10.39.178
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PCIP_DB02_1 -> 10.10.39.179
        Directory: /GMP_PCIP_DB02_1
            length: 16
            contents: /GMP_PCIP_DB02_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.179
                length: 12
                contents: 10.10.39.179
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_ATM_DB01_1 -> 10.10.39.216
        Directory: /GMP_ATM_DB01_1
            length: 15
            contents: /GMP_ATM_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.216
                length: 12
                contents: 10.10.39.216
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_ATM_DB02_1 -> 10.10.39.217
        Directory: /GMP_ATM_DB02_1
            length: 15
            contents: /GMP_ATM_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.217
                length: 12
                contents: 10.10.39.217
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PMC_DB01_1 -> 10.10.39.208
        Directory: /GMP_PMC_DB01_1
            length: 15
            contents: /GMP_PMC_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.208
                length: 12
                contents: 10.10.39.208
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_PMC_DB02_1 -> 10.10.39.209
        Directory: /GMP_PMC_DB02_1
            length: 15
            contents: /GMP_PMC_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.209
                length: 12
                contents: 10.10.39.209
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPCDC_DB01_1 -> 10.10.39.212
        Directory: /GMP_SPCDC_DB01_1
            length: 17
            contents: /GMP_SPCDC_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.212
                length: 12
                contents: 10.10.39.212
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPCDC_DB02_1 -> 10.10.39.213
        Directory: /GMP_SPCDC_DB02_1
            length: 17
            contents: /GMP_SPCDC_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.213
                length: 12
                contents: 10.10.39.213
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_ZCCDC_DB01_1 -> 10.10.39.210
        Directory: /GMP_ZCCDC_DB01_1
            length: 17
            contents: /GMP_ZCCDC_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.210
                length: 12
                contents: 10.10.39.210
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_ZCCDC_DB02_1 -> 10.10.39.211
        Directory: /GMP_ZCCDC_DB02_1
            length: 17
            contents: /GMP_ZCCDC_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.211
                length: 12
                contents: 10.10.39.211
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPCOM_DB01_1 -> 10.10.39.202
        Directory: /GMP_SPCOM_DB01_1
            length: 17
            contents: /GMP_SPCOM_DB01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.202
                length: 12
                contents: 10.10.39.202
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_SPCOM_DB02_1 -> 10.10.39.203
        Directory: /GMP_SPCOM_DB02_1
            length: 17
            contents: /GMP_SPCOM_DB02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.203
                length: 12
                contents: 10.10.39.203
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /VS_RLZYGLYH_XC_01_1 -> 10.10.29.136
        Directory: /VS_RLZYGLYH_XC_01_1
            length: 20
            contents: /VS_RLZYGLYH_XC_01_1
        Groups
            Value Follows: Yes
            Group: 10.10.29.136
                length: 12
                contents: 10.10.29.136
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /VS_RLZYGLYH_XC_02_1 -> 10.10.29.174
        Directory: /VS_RLZYGLYH_XC_02_1
            length: 20
            contents: /VS_RLZYGLYH_XC_02_1
        Groups
            Value Follows: Yes
            Group: 10.10.29.174
                length: 12
                contents: 10.10.29.174
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMPHR_222_1 -> 10.10.29.186
        Directory: /GMPHR_222_1
            length: 12
            contents: /GMPHR_222_1
        Groups
            Value Follows: Yes
            Group: 10.10.29.186
                length: 12
                contents: 10.10.29.186
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMPHR_223_1 -> 10.10.29.187
        Directory: /GMPHR_223_1
            length: 12
            contents: /GMPHR_223_1
        Groups
            Value Follows: Yes
            Group: 10.10.29.187
                length: 12
                contents: 10.10.29.187
            Value Follows: No
    Value Follows: Yes
     […]Export List Entry: /GHGL_1 -> 10.10.17.121 10.10.17.116 10.10.17.117 10.10.17.118 10.10.17.119 10.10.17.120 10.10.17.122 10.10.17.123 10.10.17.124 10.10.17.125 10.10.17.126 10.10.17.127 10.10.17.128 10.10.17.129 10.10.17.130 10.10.17
        Directory: /GHGL_1
            length: 7
            contents: /GHGL_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.17.121
                length: 12
                contents: 10.10.17.121
            Value Follows: Yes
            Group: 10.10.17.116
                length: 12
                contents: 10.10.17.116
            Value Follows: Yes
            Group: 10.10.17.117
                length: 12
                contents: 10.10.17.117
            Value Follows: Yes
            Group: 10.10.17.118
                length: 12
                contents: 10.10.17.118
            Value Follows: Yes
            Group: 10.10.17.119
                length: 12
                contents: 10.10.17.119
            Value Follows: Yes
            Group: 10.10.17.120
                length: 12
                contents: 10.10.17.120
            Value Follows: Yes
            Group: 10.10.17.122
                length: 12
                contents: 10.10.17.122
            Value Follows: Yes
            Group: 10.10.17.123
                length: 12
                contents: 10.10.17.123
            Value Follows: Yes
            Group: 10.10.17.124
                length: 12
                contents: 10.10.17.124
            Value Follows: Yes
            Group: 10.10.17.125
                length: 12
                contents: 10.10.17.125
            Value Follows: Yes
            Group: 10.10.17.126
                length: 12
                contents: 10.10.17.126
            Value Follows: Yes
            Group: 10.10.17.127
                length: 12
                contents: 10.10.17.127
            Value Follows: Yes
            Group: 10.10.17.128
                length: 12
                contents: 10.10.17.128
            Value Follows: Yes
            Group: 10.10.17.129
                length: 12
                contents: 10.10.17.129
            Value Follows: Yes
            Group: 10.10.17.130
                length: 12
                contents: 10.10.17.130
            Value Follows: Yes
            Group: 10.10.17.131
                length: 12
                contents: 10.10.17.131
            Value Follows: Yes
            Group: 10.10.17.132
                length: 12
                contents: 10.10.17.132
            Value Follows: Yes
            Group: 10.10.17.133
                length: 12
                contents: 10.10.17.133
            Value Follows: Yes
            Group: 10.10.29.196
                length: 12
                contents: 10.10.29.196
            Value Follows: Yes
            Group: 10.10.29.198
                length: 12
                contents: 10.10.29.198
            Value Follows: Yes
            Group: 10.10.29.199
                length: 12
                contents: 10.10.29.199
            Value Follows: Yes
            Group: 10.10.29.200
                length: 12
                contents: 10.10.29.200
            Value Follows: Yes
            Group: 10.10.29.201
                length: 12
                contents: 10.10.29.201
            Value Follows: Yes
            Group: 10.10.29.202
                length: 12
                contents: 10.10.29.202
            Value Follows: Yes
            Group: 10.10.29.203
                length: 12
                contents: 10.10.29.203
            Value Follows: Yes
            Group: 10.10.29.204
                length: 12
                contents: 10.10.29.204
            Value Follows: Yes
            Group: 10.10.29.205
                length: 12
                contents: 10.10.29.205
            Value Follows: Yes
            Group: 10.10.29.206
                length: 12
                contents: 10.10.29.206
            Value Follows: Yes
            Group: 10.10.29.207
                length: 12
                contents: 10.10.29.207
            Value Follows: Yes
            Group: 10.10.29.208
                length: 12
                contents: 10.10.29.208
            Value Follows: Yes
            Group: 10.10.29.210
                length: 12
                contents: 10.10.29.210
            Value Follows: Yes
            Group: 10.10.29.211
                length: 12
                contents: 10.10.29.211
            Value Follows: Yes
            Group: 10.10.29.212
                length: 12
                contents: 10.10.29.212
            Value Follows: Yes
            Group: 10.10.29.213
                length: 12
                contents: 10.10.29.213
            Value Follows: Yes
            Group: 10.10.29.214
                length: 12
                contents: 10.10.29.214
            Value Follows: Yes
            Group: 10.9.29.141
                length: 11
                contents: 10.9.29.141
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.29.142
                length: 11
                contents: 10.9.29.142
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.29.143
                length: 11
                contents: 10.9.29.143
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.101
                length: 11
                contents: 10.9.40.101
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.102
                length: 11
                contents: 10.9.40.102
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.103
                length: 11
                contents: 10.9.40.103
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.104
                length: 11
                contents: 10.9.40.104
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.105
                length: 11
                contents: 10.9.40.105
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.106
                length: 11
                contents: 10.9.40.106
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.107
                length: 11
                contents: 10.9.40.107
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.108
                length: 11
                contents: 10.9.40.108
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.109
                length: 11
                contents: 10.9.40.109
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.110
                length: 11
                contents: 10.9.40.110
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.111
                length: 11
                contents: 10.9.40.111
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.112
                length: 11
                contents: 10.9.40.112
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.113
                length: 11
                contents: 10.9.40.113
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.114
                length: 11
                contents: 10.9.40.114
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.115
                length: 11
                contents: 10.9.40.115
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.116
                length: 11
                contents: 10.9.40.116
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.117
                length: 11
                contents: 10.9.40.117
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.118
                length: 11
                contents: 10.9.40.118
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.119
                length: 11
                contents: 10.9.40.119
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.120
                length: 11
                contents: 10.9.40.120
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.121
                length: 11
                contents: 10.9.40.121
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.122
                length: 11
                contents: 10.9.40.122
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.123
                length: 11
                contents: 10.9.40.123
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.124
                length: 11
                contents: 10.9.40.124
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.125
                length: 11
                contents: 10.9.40.125
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.126
                length: 11
                contents: 10.9.40.126
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.127
                length: 11
                contents: 10.9.40.127
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.40.128
                length: 11
                contents: 10.9.40.128
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /XTBG_SZ -> 10.10.34.46 10.10.34.53 10.10.34.52 10.10.34.51 10.10.34.50 10.10.34.49 10.10.34.54 10.10.34.55 10.10.34.58 10.10.34.59 10.10.34.60 10.10.34.61
        Directory: /XTBG_SZ
            length: 8
            contents: /XTBG_SZ
        Groups
            Value Follows: Yes
            Group: 10.10.34.46
                length: 11
                contents: 10.10.34.46
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.53
                length: 11
                contents: 10.10.34.53
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.52
                length: 11
                contents: 10.10.34.52
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.51
                length: 11
                contents: 10.10.34.51
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.50
                length: 11
                contents: 10.10.34.50
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.49
                length: 11
                contents: 10.10.34.49
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.54
                length: 11
                contents: 10.10.34.54
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.55
                length: 11
                contents: 10.10.34.55
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.58
                length: 11
                contents: 10.10.34.58
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.59
                length: 11
                contents: 10.10.34.59
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.60
                length: 11
                contents: 10.10.34.60
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.34.61
                length: 11
                contents: 10.10.34.61
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_atm_db_1 -> 10.10.43.65
        Directory: /gmp_atm_db_1
            length: 13
            contents: /gmp_atm_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.65
                length: 11
                contents: 10.10.43.65
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_jadp_db_1 -> 10.10.43.64
        Directory: /gmp_jadp_db_1
            length: 14
            contents: /gmp_jadp_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.64
                length: 11
                contents: 10.10.43.64
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spcdc_db_1 -> 10.10.43.63
        Directory: /gmp_spcdc_db_1
            length: 15
            contents: /gmp_spcdc_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.63
                length: 11
                contents: 10.10.43.63
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_zccdc_db_1 -> 10.10.43.62
        Directory: /gmp_zccdc_db_1
            length: 15
            contents: /gmp_zccdc_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.62
                length: 11
                contents: 10.10.43.62
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_pmc_db_1 -> 10.10.43.61
        Directory: /gmp_pmc_db_1
            length: 13
            contents: /gmp_pmc_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.61
                length: 11
                contents: 10.10.43.61
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spre_db_1 -> 10.10.43.59
        Directory: /gmp_spre_db_1
            length: 14
            contents: /gmp_spre_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.59
                length: 11
                contents: 10.10.43.59
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spcom_db_1 -> 10.10.43.58
        Directory: /gmp_spcom_db_1
            length: 15
            contents: /gmp_spcom_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.58
                length: 11
                contents: 10.10.43.58
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spemer_db_1 -> 10.10.43.57
        Directory: /gmp_spemer_db_1
            length: 16
            contents: /gmp_spemer_db_1
        Groups
            Value Follows: Yes
            Group: 10.10.43.57
                length: 11
                contents: 10.10.43.57
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_speqpm_db_1 -> 10.10.43.56
        Directory: /gmp_speqpm_db_1
            length: 16
            contents: /gmp_speqpm_db_1
        Groups
            Value Follows: Yes
            Group: 10.10.43.56
                length: 11
                contents: 10.10.43.56
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spsafe_db_1 -> 10.10.43.55
        Directory: /gmp_spsafe_db_1
            length: 16
            contents: /gmp_spsafe_db_1
        Groups
            Value Follows: Yes
            Group: 10.10.43.55
                length: 11
                contents: 10.10.43.55
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spdisp_db_1 -> 10.10.43.54
        Directory: /gmp_spdisp_db_1
            length: 16
            contents: /gmp_spdisp_db_1
        Groups
            Value Follows: Yes
            Group: 10.10.43.54
                length: 11
                contents: 10.10.43.54
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_speqpq_db_1 -> 10.10.43.53
        Directory: /gmp_speqpq_db_1
            length: 16
            contents: /gmp_speqpq_db_1
        Groups
            Value Follows: Yes
            Group: 10.10.43.53
                length: 11
                contents: 10.10.43.53
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spoper_db_1 -> 10.10.43.52
        Directory: /gmp_spoper_db_1
            length: 16
            contents: /gmp_spoper_db_1
        Groups
            Value Follows: Yes
            Group: 10.10.43.52
                length: 11
                contents: 10.10.43.52
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_mmwa_db_1 -> 10.10.43.51
        Directory: /gmp_mmwa_db_1
            length: 14
            contents: /gmp_mmwa_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.51
                length: 11
                contents: 10.10.43.51
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_mmre_db_1 -> 10.10.43.50
        Directory: /gmp_mmre_db_1
            length: 14
            contents: /gmp_mmre_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.50
                length: 11
                contents: 10.10.43.50
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_pms_db_1 -> 10.10.43.49
        Directory: /gmp_pms_db_1
            length: 13
            contents: /gmp_pms_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.49
                length: 11
                contents: 10.10.43.49
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_pcinpco_db_1 -> 10.10.43.48
        Directory: /gmp_pcinpco_db_1
            length: 17
            contents: /gmp_pcinpco_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.48
                length: 11
                contents: 10.10.43.48
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_pcinp_db_1 -> 10.10.43.47
        Directory: /gmp_pcinp_db_1
            length: 15
            contents: /gmp_pcinp_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.47
                length: 11
                contents: 10.10.43.47
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_pcip_db_1 -> 10.10.43.46
        Directory: /gmp_pcip_db_1
            length: 14
            contents: /gmp_pcip_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.46
                length: 11
                contents: 10.10.43.46
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_sps_db_1 -> 10.10.43.45
        Directory: /gmp_sps_db_1
            length: 13
            contents: /gmp_sps_db_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.43.45
                length: 11
                contents: 10.10.43.45
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_mmcont_db_1 -> 10.10.43.60
        Directory: /gmp_mmcont_db_1
            length: 16
            contents: /gmp_mmcont_db_1
        Groups
            Value Follows: Yes
            Group: 10.10.43.60
                length: 11
                contents: 10.10.43.60
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_ggfw_db01_1 -> 10.10.39.168
        Directory: /gmp_ggfw_db01_1
            length: 16
            contents: /gmp_ggfw_db01_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.168
                length: 12
                contents: 10.10.39.168
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_ggfw_db02_1 -> 10.10.39.169
        Directory: /gmp_ggfw_db02_1
            length: 16
            contents: /gmp_ggfw_db02_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.169
                length: 12
                contents: 10.10.39.169
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spprod_db01_1 -> 10.10.39.170
        Directory: /gmp_spprod_db01_1
            length: 18
            contents: /gmp_spprod_db01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.170
                length: 12
                contents: 10.10.39.170
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_spprod_db02_1 -> 10.10.39.171
        Directory: /gmp_spprod_db02_1
            length: 18
            contents: /gmp_spprod_db02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.171
                length: 12
                contents: 10.10.39.171
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_mmreq_db01_1 -> 10.10.39.172
        Directory: /gmp_mmreq_db01_1
            length: 17
            contents: /gmp_mmreq_db01_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.172
                length: 12
                contents: 10.10.39.172
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_mmreq_db02_1 -> 10.10.39.173
        Directory: /gmp_mmreq_db02_1
            length: 17
            contents: /gmp_mmreq_db02_1
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.173
                length: 12
                contents: 10.10.39.173
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gmp_sppc_bd02_1 -> 10.10.39.175
        Directory: /gmp_sppc_bd02_1
            length: 16
            contents: /gmp_sppc_bd02_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.175
                length: 12
                contents: 10.10.39.175
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /yngrcdb -> 10.10.46.227
        Directory: /yngrcdb
            length: 8
            contents: /yngrcdb
        Groups
            Value Follows: Yes
            Group: 10.10.46.227
                length: 12
                contents: 10.10.46.227
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gxgrcdb -> 10.10.46.228
        Directory: /gxgrcdb
            length: 8
            contents: /gxgrcdb
        Groups
            Value Follows: Yes
            Group: 10.10.46.228
                length: 12
                contents: 10.10.46.228
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /hngrcdb -> 10.10.46.230
        Directory: /hngrcdb
            length: 8
            contents: /hngrcdb
        Groups
            Value Follows: Yes
            Group: 10.10.46.230
                length: 12
                contents: 10.10.46.230
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /vs_zbkgtszj_1_2 -> 10.10.46.53 10.10.46.54
        Directory: /vs_zbkgtszj_1_2
            length: 16
            contents: /vs_zbkgtszj_1_2
        Groups
            Value Follows: Yes
            Group: 10.10.46.53
                length: 11
                contents: 10.10.46.53
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.46.54
                length: 11
                contents: 10.10.46.54
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /zsgxpt_zsfw_cshj_10 -> 10.10.46.20
        Directory: /zsgxpt_zsfw_cshj_10
            length: 20
            contents: /zsgxpt_zsfw_cshj_10
        Groups
            Value Follows: Yes
            Group: 10.10.46.20
                length: 11
                contents: 10.10.46.20
                fill bytes: opaque data
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_JADP_DB01_1 -> 10.10.39.105
        Directory: /GMP_JADP_DB01_1
            length: 16
            contents: /GMP_JADP_DB01_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.105
                length: 12
                contents: 10.10.39.105
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /GMP_JADP_DB02_1 -> 10.10.39.106
        Directory: /GMP_JADP_DB02_1
            length: 16
            contents: /GMP_JADP_DB02_1
        Groups
            Value Follows: Yes
            Group: 10.10.39.106
                length: 12
                contents: 10.10.39.106
            Value Follows: No
    Value Follows: Yes
    Export List Entry: /gzgrcdb -> 10.10.32.219
        Directory: /gzgrcdb
            length: 8
            contents: /gzgrcdb
        Groups
            Value Follows: Yes
            Group: 10.10.32.219
                length: 12
                contents: 10.10.32.219
            Value Follows: No
    Value Follows: Yes
     […]Export List Entry: /cncp_tangxia_nas -> 10.10.97.1 10.10.97.2 10.10.97.3 10.10.97.4 10.10.97.5 10.10.97.6 10.10.97.7 10.10.97.8 10.10.97.9 10.10.97.10 10.10.97.11 10.10.97.12 10.10.97.13 10.10.97.14 10.10.97.15 10.10.97.16 10.10.97.1
        Directory: /cncp_tangxia_nas
            length: 17
            contents: /cncp_tangxia_nas
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.97.1
                length: 10
                contents: 10.10.97.1
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.2
                length: 10
                contents: 10.10.97.2
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.3
                length: 10
                contents: 10.10.97.3
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.4
                length: 10
                contents: 10.10.97.4
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.5
                length: 10
                contents: 10.10.97.5
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.6
                length: 10
                contents: 10.10.97.6
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.7
                length: 10
                contents: 10.10.97.7
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.8
                length: 10
                contents: 10.10.97.8
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.9
                length: 10
                contents: 10.10.97.9
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.10
                length: 11
                contents: 10.10.97.10
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.11
                length: 11
                contents: 10.10.97.11
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.12
                length: 11
                contents: 10.10.97.12
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.13
                length: 11
                contents: 10.10.97.13
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.14
                length: 11
                contents: 10.10.97.14
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.15
                length: 11
                contents: 10.10.97.15
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.16
                length: 11
                contents: 10.10.97.16
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.17
                length: 11
                contents: 10.10.97.17
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.18
                length: 11
                contents: 10.10.97.18
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.19
                length: 11
                contents: 10.10.97.19
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.10.97.20
                length: 11
                contents: 10.10.97.20
                fill bytes: opaque data
            Value Follows: No
    Value Follows: No
```

# 175517	2025-11-12 11:03:45.438156	10.10.39.236	10.92.218.76	MOUNT	160	V3 EXPORT Call (Reply In 175531)	977	8752

```sh
Frame 175517: 160 bytes on wire (1280 bits), 160 bytes captured (1280 bits)
    Encapsulation type: Linux cooked-mode capture v1 (25)
    Arrival Time: Nov 12, 2025 11:03:45.438156000 中国标准时间
    UTC Arrival Time: Nov 12, 2025 03:03:45.438156000 UTC
    Epoch Arrival Time: 1762916625.438156000
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 0.000009000 seconds]
    [Time delta from previous displayed frame: 0.011921000 seconds]
    [Time since reference or first frame: 2.885993000 seconds]
    Frame Number: 175517
    Frame Length: 160 bytes (1280 bits)
    Capture Length: 160 bytes (1280 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:ethertype:ip:tcp:rpc]
    [Coloring Rule Name: TCP]
    [Coloring Rule String: tcp]
Linux cooked capture v1
    Packet type: Sent by us (4)
    Link-layer address type: Ethernet (1)
    Link-layer address length: 6
    Source: ae:1b:04:76:46:b4 (ae:1b:04:76:46:b4)
    Unused: 008b
    Protocol: IPv4 (0x0800)
Internet Protocol Version 4, Src: 10.10.39.236, Dst: 10.92.218.76
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 144
    Identification: 0x4299 (17049)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 64
    Protocol: TCP (6)
    Header Checksum: 0xe130 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 10.10.39.236
    Destination Address: 10.92.218.76
    [Stream index: 350]
Transmission Control Protocol, Src Port: 977, Dst Port: 8752, Seq: 1, Ack: 1, Len: 92
    Source Port: 977
    Destination Port: 8752
    [Stream index: 2163]
    [Stream Packet Number: 10]
    [Conversation completeness: Complete, WITH_DATA (31)]
        ..0. .... = RST: Absent
        ...1 .... = FIN: Present
        .... 1... = Data: Present
        .... .1.. = ACK: Present
        .... ..1. = SYN-ACK: Present
        .... ...1 = SYN: Present
        [Completeness Flags: ·FDASS]
    [TCP Segment Len: 92]
    Sequence Number: 1    (relative sequence number)
    Sequence Number (raw): 2420291919
    [Next Sequence Number: 93    (relative sequence number)]
    Acknowledgment Number: 1    (relative ack number)
    Acknowledgment number (raw): 2300863794
    1000 .... = Header Length: 32 bytes (8)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 126
    [Calculated window size: 64512]
    [Window size scaling factor: 512]
    Checksum: 0x1721 [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - Timestamps: TSval 2353678072, TSecr 54382606
            Kind: Time Stamp Option (8)
            Length: 10
            Timestamp value: 2353678072
            Timestamp echo reply: 54382606
    [Timestamps]
        [Time since first frame in this TCP stream: 0.000296000 seconds]
        [Time since previous frame in this TCP stream: 0.000060000 seconds]
    [SEQ/ACK analysis]
        [iRTT: 0.000225000 seconds]
        [Bytes in flight: 92]
        [Bytes sent since last PSH flag: 92]
    TCP payload (92 bytes)
Remote Procedure Call, Type:Call XID:0x0c7145be
    Fragment header: Last fragment, 88 bytes
        1... .... .... .... .... .... .... .... = Last Fragment: Yes
        .000 0000 0000 0000 0000 0000 0101 1000 = Fragment Length: 88
    XID: 0x0c7145be (208750014)
    Message Type: Call (0)
    RPC Version: 2
    Program: MOUNT (100005)
    Program Version: 3
    Procedure: EXPORT (5)
    [The reply to this request is in frame 175531]
    Credentials
        Flavor: AUTH_UNIX (1)
        Length: 48
        Stamp: 0x6913f911
        Machine Name: localhost.localdomain
            length: 21
            contents: localhost.localdomain
            fill bytes: opaque data
        UID: 0
        GID: 0
        Auxiliary GIDs (1) [0]
            GID: 0
    Verifier
        Flavor: AUTH_NULL (0)
        Length: 0
Mount Service
    [Program Version: 3]
    [V3 Procedure: EXPORT (5)]
```

# 175531	2025-11-12 11:03:45.438502	10.92.218.76	10.10.39.236	MOUNT	176	V3 EXPORT Reply (Call In 175517)	8752	977

```sh
Frame 175531: 176 bytes on wire (1408 bits), 176 bytes captured (1408 bits)
    Encapsulation type: Linux cooked-mode capture v1 (25)
    Arrival Time: Nov 12, 2025 11:03:45.438502000 中国标准时间
    UTC Arrival Time: Nov 12, 2025 03:03:45.438502000 UTC
    Epoch Arrival Time: 1762916625.438502000
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 0.000016000 seconds]
    [Time delta from previous displayed frame: 0.000346000 seconds]
    [Time since reference or first frame: 2.886339000 seconds]
    Frame Number: 175531
    Frame Length: 176 bytes (1408 bits)
    Capture Length: 176 bytes (1408 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:ethertype:vlan:ethertype:ip:tcp:rpc:mount]
    [Coloring Rule Name: TCP]
    [Coloring Rule String: tcp]
Linux cooked capture v1
    Packet type: Unicast to us (0)
    Link-layer address type: Ethernet (1)
    Link-layer address length: 6
    Source: HuaweiTechno_3c:d3:1e (20:0b:c7:3c:d3:1e)
    Unused: 0000
    Protocol: 802.1Q Virtual LAN (0x8100)
802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 2068
    000. .... .... .... = Priority: Best Effort (default) (0)
    ...0 .... .... .... = DEI: Ineligible
    .... 1000 0001 0100 = ID: 2068
    Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 10.92.218.76, Dst: 10.10.39.236
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 156
    Identification: 0x8acf (35535)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 61
    Protocol: TCP (6)
    Header Checksum: 0x9bee [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 10.92.218.76
    Destination Address: 10.10.39.236
    [Stream index: 350]
Transmission Control Protocol, Src Port: 8752, Dst Port: 977, Seq: 1, Ack: 93, Len: 104
    Source Port: 8752
    Destination Port: 977
    [Stream index: 2163]
    [Stream Packet Number: 16]
    [Conversation completeness: Complete, WITH_DATA (31)]
        ..0. .... = RST: Absent
        ...1 .... = FIN: Present
        .... 1... = Data: Present
        .... .1.. = ACK: Present
        .... ..1. = SYN-ACK: Present
        .... ...1 = SYN: Present
        [Completeness Flags: ·FDASS]
    [TCP Segment Len: 104]
    Sequence Number: 1    (relative sequence number)
    Sequence Number (raw): 2300863794
    [Next Sequence Number: 105    (relative sequence number)]
    Acknowledgment Number: 93    (relative ack number)
    Acknowledgment number (raw): 2420292011
    1000 .... = Header Length: 32 bytes (8)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 227
    [Calculated window size: 29056]
    [Window size scaling factor: 128]
    Checksum: 0x878b [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - Timestamps: TSval 54382607, TSecr 2353678072
            Kind: Time Stamp Option (8)
            Length: 10
            Timestamp value: 54382607
            Timestamp echo reply: 2353678072
    [Timestamps]
        [Time since first frame in this TCP stream: 0.000642000 seconds]
        [Time since previous frame in this TCP stream: 0.000182000 seconds]
    [SEQ/ACK analysis]
        [iRTT: 0.000225000 seconds]
        [Bytes in flight: 104]
        [Bytes sent since last PSH flag: 104]
    TCP payload (104 bytes)
Remote Procedure Call, Type:Reply XID:0x0c7145be
    Fragment header: Last fragment, 100 bytes
        1... .... .... .... .... .... .... .... = Last Fragment: Yes
        .000 0000 0000 0000 0000 0000 0110 0100 = Fragment Length: 100
    XID: 0x0c7145be (208750014)
    Message Type: Reply (1)
    [Program: MOUNT (100005)]
    [Program Version: 3]
    [Procedure: EXPORT (5)]
    Reply State: accepted (0)
    [This is a reply to a request in frame 175517]
    [Time from request: 0.000346000 seconds]
    Verifier
        Flavor: AUTH_NULL (0)
        Length: 0
    Accept State: RPC executed successfully (0)
Mount Service
    [Program Version: 3]
    [V3 Procedure: EXPORT (5)]
    Value Follows: Yes
    Export List Entry: /fs/zcgl/scxt -> 10.10.39.0/24 10.9.50.0/24
        Directory: /fs/zcgl/scxt
            length: 13
            contents: /fs/zcgl/scxt
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.50.0/24
                length: 12
                contents: 10.9.50.0/24
            Value Follows: No
    Value Follows: No
```

# 175532	2025-11-12 11:03:45.438502	10.92.218.76	10.10.39.236	MOUNT	176	[RPC duplicate of #175531][TCP Fast Retransmission] V3 EXPORT Reply (Call In 175517)	8752	977

```sh
Frame 175532: 176 bytes on wire (1408 bits), 176 bytes captured (1408 bits)
    Encapsulation type: Linux cooked-mode capture v1 (25)
    Arrival Time: Nov 12, 2025 11:03:45.438502000 中国标准时间
    UTC Arrival Time: Nov 12, 2025 03:03:45.438502000 UTC
    Epoch Arrival Time: 1762916625.438502000
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 0.000000000 seconds]
    [Time delta from previous displayed frame: 0.000000000 seconds]
    [Time since reference or first frame: 2.886339000 seconds]
    Frame Number: 175532
    Frame Length: 176 bytes (1408 bits)
    Capture Length: 176 bytes (1408 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:ethertype:vlan:ethertype:ip:tcp:rpc:mount]
    [Coloring Rule Name: Bad TCP]
    [Coloring Rule String: tcp.analysis.flags && !tcp.analysis.window_update && !tcp.analysis.keep_alive && !tcp.analysis.keep_alive_ack]
Linux cooked capture v1
    Packet type: Unicast to us (0)
    Link-layer address type: Ethernet (1)
    Link-layer address length: 6
    Source: HuaweiTechno_3c:d3:1e (20:0b:c7:3c:d3:1e)
    Unused: 0000
    Protocol: 802.1Q Virtual LAN (0x8100)
802.1Q Virtual LAN, PRI: 0, DEI: 0, ID: 2068
    000. .... .... .... = Priority: Best Effort (default) (0)
    ...0 .... .... .... = DEI: Ineligible
    .... 1000 0001 0100 = ID: 2068
    Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 10.92.218.76, Dst: 10.10.39.236
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 156
    Identification: 0x8acf (35535)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 61
    Protocol: TCP (6)
    Header Checksum: 0x9bee [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 10.92.218.76
    Destination Address: 10.10.39.236
    [Stream index: 350]
Transmission Control Protocol, Src Port: 8752, Dst Port: 977, Seq: 1, Ack: 93, Len: 104
    Source Port: 8752
    Destination Port: 977
    [Stream index: 2163]
    [Stream Packet Number: 17]
    [Conversation completeness: Complete, WITH_DATA (31)]
        ..0. .... = RST: Absent
        ...1 .... = FIN: Present
        .... 1... = Data: Present
        .... .1.. = ACK: Present
        .... ..1. = SYN-ACK: Present
        .... ...1 = SYN: Present
        [Completeness Flags: ·FDASS]
    [TCP Segment Len: 104]
    Sequence Number: 1    (relative sequence number)
    Sequence Number (raw): 2300863794
    [Next Sequence Number: 105    (relative sequence number)]
    Acknowledgment Number: 93    (relative ack number)
    Acknowledgment number (raw): 2420292011
    1000 .... = Header Length: 32 bytes (8)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 227
    [Calculated window size: 29056]
    [Window size scaling factor: 128]
    Checksum: 0x878b [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - Timestamps: TSval 54382607, TSecr 2353678072
            Kind: Time Stamp Option (8)
            Length: 10
            Timestamp value: 54382607
            Timestamp echo reply: 2353678072
    [Timestamps]
        [Time since first frame in this TCP stream: 0.000642000 seconds]
        [Time since previous frame in this TCP stream: 0.000000000 seconds]
    [SEQ/ACK analysis]
        [iRTT: 0.000225000 seconds]
        [Bytes in flight: 104]
        [Bytes sent since last PSH flag: 104]
        [TCP Analysis Flags]
            [Expert Info (Note/Sequence): This frame is a (suspected) fast retransmission]
                [This frame is a (suspected) fast retransmission]
                [Severity level: Note]
                [Group: Sequence]
            [Expert Info (Note/Sequence): This frame is a (suspected) retransmission]
                [This frame is a (suspected) retransmission]
                [Severity level: Note]
                [Group: Sequence]
    TCP payload (104 bytes)
Remote Procedure Call, Type:Reply XID:0x0c7145be
    Fragment header: Last fragment, 100 bytes
        1... .... .... .... .... .... .... .... = Last Fragment: Yes
        .000 0000 0000 0000 0000 0000 0110 0100 = Fragment Length: 100
    XID: 0x0c7145be (208750014)
    Message Type: Reply (1)
    [Program: MOUNT (100005)]
    [Program Version: 3]
    [Procedure: EXPORT (5)]
    Reply State: accepted (0)
    [This is a reply to a request in frame 175517]
    [Time from request: 0.000346000 seconds]
    [Duplicate Call/Reply]
    [Duplicate to the reply in: 175531]
    Verifier
        Flavor: AUTH_NULL (0)
        Length: 0
    Accept State: RPC executed successfully (0)
Mount Service
    [Program Version: 3]
    [V3 Procedure: EXPORT (5)]
    Value Follows: Yes
    Export List Entry: /fs/zcgl/scxt -> 10.10.39.0/24 10.9.50.0/24
        Directory: /fs/zcgl/scxt
            length: 13
            contents: /fs/zcgl/scxt
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.50.0/24
                length: 12
                contents: 10.9.50.0/24
            Value Follows: No
    Value Follows: No
```

# 175533	2025-11-12 11:03:45.438502	10.92.218.76	10.10.39.236	MOUNT	172	[RPC duplicate of #175531][TCP Fast Retransmission] V3 EXPORT Reply (Call In 175517)	8752	977

```sh
Frame 175533: 172 bytes on wire (1376 bits), 172 bytes captured (1376 bits)
    Encapsulation type: Linux cooked-mode capture v1 (25)
    Arrival Time: Nov 12, 2025 11:03:45.438502000 中国标准时间
    UTC Arrival Time: Nov 12, 2025 03:03:45.438502000 UTC
    Epoch Arrival Time: 1762916625.438502000
    [Time shift for this packet: 0.000000000 seconds]
    [Time delta from previous captured frame: 0.000000000 seconds]
    [Time delta from previous displayed frame: 0.000000000 seconds]
    [Time since reference or first frame: 2.886339000 seconds]
    Frame Number: 175533
    Frame Length: 172 bytes (1376 bits)
    Capture Length: 172 bytes (1376 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: sll:ethertype:ip:tcp:rpc:mount]
    [Coloring Rule Name: Bad TCP]
    [Coloring Rule String: tcp.analysis.flags && !tcp.analysis.window_update && !tcp.analysis.keep_alive && !tcp.analysis.keep_alive_ack]
Linux cooked capture v1
    Packet type: Unicast to us (0)
    Link-layer address type: Ethernet (1)
    Link-layer address length: 6
    Source: HuaweiTechno_3c:d3:1e (20:0b:c7:3c:d3:1e)
    Unused: 0000
    Protocol: IPv4 (0x0800)
Internet Protocol Version 4, Src: 10.92.218.76, Dst: 10.10.39.236
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 156
    Identification: 0x8acf (35535)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 61
    Protocol: TCP (6)
    Header Checksum: 0x9bee [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 10.92.218.76
    Destination Address: 10.10.39.236
    [Stream index: 350]
Transmission Control Protocol, Src Port: 8752, Dst Port: 977, Seq: 1, Ack: 93, Len: 104
    Source Port: 8752
    Destination Port: 977
    [Stream index: 2163]
    [Stream Packet Number: 18]
    [Conversation completeness: Complete, WITH_DATA (31)]
        ..0. .... = RST: Absent
        ...1 .... = FIN: Present
        .... 1... = Data: Present
        .... .1.. = ACK: Present
        .... ..1. = SYN-ACK: Present
        .... ...1 = SYN: Present
        [Completeness Flags: ·FDASS]
    [TCP Segment Len: 104]
    Sequence Number: 1    (relative sequence number)
    Sequence Number (raw): 2300863794
    [Next Sequence Number: 105    (relative sequence number)]
    Acknowledgment Number: 93    (relative ack number)
    Acknowledgment number (raw): 2420292011
    1000 .... = Header Length: 32 bytes (8)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 227
    [Calculated window size: 29056]
    [Window size scaling factor: 128]
    Checksum: 0x878b [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    Options: (12 bytes), No-Operation (NOP), No-Operation (NOP), Timestamps
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - No-Operation (NOP)
            Kind: No-Operation (1)
        TCP Option - Timestamps: TSval 54382607, TSecr 2353678072
            Kind: Time Stamp Option (8)
            Length: 10
            Timestamp value: 54382607
            Timestamp echo reply: 2353678072
    [Timestamps]
        [Time since first frame in this TCP stream: 0.000642000 seconds]
        [Time since previous frame in this TCP stream: 0.000000000 seconds]
    [SEQ/ACK analysis]
        [iRTT: 0.000225000 seconds]
        [Bytes in flight: 104]
        [Bytes sent since last PSH flag: 104]
        [TCP Analysis Flags]
            [Expert Info (Note/Sequence): This frame is a (suspected) fast retransmission]
                [This frame is a (suspected) fast retransmission]
                [Severity level: Note]
                [Group: Sequence]
            [Expert Info (Note/Sequence): This frame is a (suspected) retransmission]
                [This frame is a (suspected) retransmission]
                [Severity level: Note]
                [Group: Sequence]
    TCP payload (104 bytes)
Remote Procedure Call, Type:Reply XID:0x0c7145be
    Fragment header: Last fragment, 100 bytes
        1... .... .... .... .... .... .... .... = Last Fragment: Yes
        .000 0000 0000 0000 0000 0000 0110 0100 = Fragment Length: 100
    XID: 0x0c7145be (208750014)
    Message Type: Reply (1)
    [Program: MOUNT (100005)]
    [Program Version: 3]
    [Procedure: EXPORT (5)]
    Reply State: accepted (0)
    [This is a reply to a request in frame 175517]
    [Time from request: 0.000346000 seconds]
    [Duplicate Call/Reply]
    [Duplicate to the reply in: 175531]
    Verifier
        Flavor: AUTH_NULL (0)
        Length: 0
    Accept State: RPC executed successfully (0)
Mount Service
    [Program Version: 3]
    [V3 Procedure: EXPORT (5)]
    Value Follows: Yes
    Export List Entry: /fs/zcgl/scxt -> 10.10.39.0/24 10.9.50.0/24
        Directory: /fs/zcgl/scxt
            length: 13
            contents: /fs/zcgl/scxt
            fill bytes: opaque data
        Groups
            Value Follows: Yes
            Group: 10.10.39.0/24
                length: 13
                contents: 10.10.39.0/24
                fill bytes: opaque data
            Value Follows: Yes
            Group: 10.9.50.0/24
                length: 12
                contents: 10.9.50.0/24
            Value Follows: No
    Value Follows: No
```

