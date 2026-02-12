# `dis -lx nfs_do_writepage`

```sh
crash> dis -lx nfs_do_writepage
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 669
0xffffffffc08b2460 <nfs_do_writepage>:	data32 data32 data32 xchg %ax,%ax [FTRACE NOP]
0xffffffffc08b2465 <nfs_do_writepage+0x5>:	push   %r15
0xffffffffc08b2467 <nfs_do_writepage+0x7>:	push   %r14
0xffffffffc08b2469 <nfs_do_writepage+0x9>:	push   %r13
0xffffffffc08b246b <nfs_do_writepage+0xb>:	push   %r12
0xffffffffc08b246d <nfs_do_writepage+0xd>:	mov    %rdx,%r12
0xffffffffc08b2470 <nfs_do_writepage+0x10>:	push   %rbp
0xffffffffc08b2471 <nfs_do_writepage+0x11>:	push   %rbx
0xffffffffc08b2472 <nfs_do_writepage+0x12>:	mov    %rsi,%r13
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/compiler.h: 223
0xffffffffc08b2475 <nfs_do_writepage+0x15>:	mov    0x8(%rdi),%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 669
0xffffffffc08b2479 <nfs_do_writepage+0x19>:	mov    %rdi,%rbx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 145
0xffffffffc08b247c <nfs_do_writepage+0x1c>:	lea    -0x1(%rdx),%rax
0xffffffffc08b2480 <nfs_do_writepage+0x20>:	and    $0x1,%edx
0xffffffffc08b2483 <nfs_do_writepage+0x23>:	cmove  %rdi,%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/compiler.h: 223
0xffffffffc08b2487 <nfs_do_writepage+0x27>:	mov    0x8(%rax),%rcx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 145
0xffffffffc08b248b <nfs_do_writepage+0x2b>:	lea    -0x1(%rcx),%rdx
0xffffffffc08b248f <nfs_do_writepage+0x2f>:	and    $0x1,%ecx
0xffffffffc08b2492 <nfs_do_writepage+0x32>:	cmove  %rax,%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 318
0xffffffffc08b2496 <nfs_do_writepage+0x36>:	mov    (%rdx),%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 340
0xffffffffc08b2499 <nfs_do_writepage+0x39>:	test   $0x40000,%edx
0xffffffffc08b249f <nfs_do_writepage+0x3f>:	je     0xffffffffc08b24ad <nfs_do_writepage+0x4d>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 318
0xffffffffc08b24a1 <nfs_do_writepage+0x41>:	mov    (%rax),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 340
0xffffffffc08b24a4 <nfs_do_writepage+0x44>:	test   $0x2,%ah
0xffffffffc08b24a7 <nfs_do_writepage+0x47>:	jne    0xffffffffc08b2646 <nfs_do_writepage+0x1e6>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/mm.h: 1255
0xffffffffc08b24ad <nfs_do_writepage+0x4d>:	mov    0x20(%rbx),%rsi
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 672
0xffffffffc08b24b1 <nfs_do_writepage+0x51>:	mov    %r12,%rdi
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 627
0xffffffffc08b24b4 <nfs_do_writepage+0x54>:	xor    %r14d,%r14d
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 672
0xffffffffc08b24b7 <nfs_do_writepage+0x57>:	callq  0xffffffffc08ae5b0 <nfs_pageio_cond_complete>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 629
0xffffffffc08b24bc <nfs_do_writepage+0x5c>:	mov    %rbx,%rdi
0xffffffffc08b24bf <nfs_do_writepage+0x5f>:	callq  0xffffffffc08b1df0 <nfs_lock_and_join_requests>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 630
0xffffffffc08b24c4 <nfs_do_writepage+0x64>:	test   %rax,%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 629
0xffffffffc08b24c7 <nfs_do_writepage+0x67>:	mov    %rax,%rbp
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 630
0xffffffffc08b24ca <nfs_do_writepage+0x6a>:	je     0xffffffffc08b2606 <nfs_do_writepage+0x1a6>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 633
0xffffffffc08b24d0 <nfs_do_writepage+0x70>:	cmp    $0xfffffffffffff000,%rax
0xffffffffc08b24d6 <nfs_do_writepage+0x76>:	ja     0xffffffffc08b26eb <nfs_do_writepage+0x28b>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/compiler.h: 223
0xffffffffc08b24dc <nfs_do_writepage+0x7c>:	mov    0x8(%rbx),%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 145
0xffffffffc08b24e0 <nfs_do_writepage+0x80>:	lea    -0x1(%rdx),%rax
0xffffffffc08b24e4 <nfs_do_writepage+0x84>:	and    $0x1,%edx
0xffffffffc08b24e7 <nfs_do_writepage+0x87>:	cmove  %rbx,%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/compiler.h: 223
0xffffffffc08b24eb <nfs_do_writepage+0x8b>:	mov    0x8(%rax),%rcx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 145
0xffffffffc08b24ef <nfs_do_writepage+0x8f>:	lea    -0x1(%rcx),%rdx
0xffffffffc08b24f3 <nfs_do_writepage+0x93>:	and    $0x1,%ecx
0xffffffffc08b24f6 <nfs_do_writepage+0x96>:	cmove  %rax,%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 318
0xffffffffc08b24fa <nfs_do_writepage+0x9a>:	mov    (%rdx),%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 340
0xffffffffc08b24fd <nfs_do_writepage+0x9d>:	test   $0x40000,%edx
0xffffffffc08b2503 <nfs_do_writepage+0xa3>:	jne    0xffffffffc08b262d <nfs_do_writepage+0x1cd>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/mm.h: 1242
0xffffffffc08b2509 <nfs_do_writepage+0xa9>:	mov    0x18(%rbx),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 343
0xffffffffc08b250d <nfs_do_writepage+0xad>:	mov    (%rax),%r15
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 345
0xffffffffc08b2510 <nfs_do_writepage+0xb0>:	xor    %esi,%esi
0xffffffffc08b2512 <nfs_do_writepage+0xb2>:	mov    %rbx,%rdi
0xffffffffc08b2515 <nfs_do_writepage+0xb5>:	mov    0x28(%r15),%rax
0xffffffffc08b2519 <nfs_do_writepage+0xb9>:	mov    0x400(%rax),%r14
0xffffffffc08b2520 <nfs_do_writepage+0xc0>:	callq  0xffffffffb8e25ec0 <__test_set_page_writeback>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 347
0xffffffffc08b2525 <nfs_do_writepage+0xc5>:	test   %eax,%eax
0xffffffffc08b2527 <nfs_do_writepage+0xc7>:	jne    0xffffffffc08b26fa <nfs_do_writepage+0x29a>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/atomic64_64.h: 160
0xffffffffc08b252d <nfs_do_writepage+0xcd>:	mov    $0x1,%eax
0xffffffffc08b2532 <nfs_do_writepage+0xd2>:	lock xadd %rax,0x48(%r14)
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 350
0xffffffffc08b2538 <nfs_do_writepage+0xd8>:	mov    0x23baa(%rip),%edx        # 0xffffffffc08d60e8 <nfs_congestion_kb>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/atomic64_64.h: 160
0xffffffffc08b253e <nfs_do_writepage+0xde>:	add    $0x1,%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 350
0xffffffffc08b2542 <nfs_do_writepage+0xe2>:	sar    $0x2,%edx
0xffffffffc08b2545 <nfs_do_writepage+0xe5>:	movslq %edx,%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 349
0xffffffffc08b2548 <nfs_do_writepage+0xe8>:	cmp    %rdx,%rax
0xffffffffc08b254b <nfs_do_writepage+0xeb>:	jle    0xffffffffc08b257f <nfs_do_writepage+0x11f>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev.h: 160
0xffffffffc08b254d <nfs_do_writepage+0xed>:	test   %r15,%r15
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev.h: 161
0xffffffffc08b2550 <nfs_do_writepage+0xf0>:	mov    $0xffffffffba127720,%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev.h: 160
0xffffffffc08b2557 <nfs_do_writepage+0xf7>:	je     0xffffffffc08b2571 <nfs_do_writepage+0x111>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev.h: 163
0xffffffffc08b2559 <nfs_do_writepage+0xf9>:	mov    0x28(%r15),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev.h: 165
0xffffffffc08b255d <nfs_do_writepage+0xfd>:	cmp    -0x66487cc(%rip),%rax        # 0xffffffffba269d98
0xffffffffc08b2564 <nfs_do_writepage+0x104>:	je     0xffffffffc08b2713 <nfs_do_writepage+0x2b3>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev.h: 168
0xffffffffc08b256a <nfs_do_writepage+0x10a>:	mov    0xd0(%rax),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev-defs.h: 238
0xffffffffc08b2571 <nfs_do_writepage+0x111>:	mov    0x158(%rax),%rdi
0xffffffffc08b2578 <nfs_do_writepage+0x118>:	xor    %esi,%esi
0xffffffffc08b257a <nfs_do_writepage+0x11a>:	callq  0xffffffffb8e42690 <set_wb_congested>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 318
0xffffffffc08b257f <nfs_do_writepage+0x11f>:	mov    0x40(%rbp),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 637
0xffffffffc08b2583 <nfs_do_writepage+0x123>:	test   $0x4,%al
0xffffffffc08b2585 <nfs_do_writepage+0x125>:	jne    0xffffffffc08b26f3 <nfs_do_writepage+0x293>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 639
0xffffffffc08b258b <nfs_do_writepage+0x12b>:	mov    0x18(%rbp),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 641
0xffffffffc08b258f <nfs_do_writepage+0x12f>:	mov    0x60(%rax),%edi
0xffffffffc08b2592 <nfs_do_writepage+0x132>:	callq  0xffffffffc08b10f0 <nfs_error_is_fatal_on_server>
0xffffffffc08b2597 <nfs_do_writepage+0x137>:	test   %al,%al
0xffffffffc08b2599 <nfs_do_writepage+0x139>:	jne    0xffffffffc08b2614 <nfs_do_writepage+0x1b4>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 645
0xffffffffc08b259b <nfs_do_writepage+0x13b>:	mov    %rbp,%rsi
0xffffffffc08b259e <nfs_do_writepage+0x13e>:	mov    %r12,%rdi
0xffffffffc08b25a1 <nfs_do_writepage+0x141>:	callq  0xffffffffc08ae020 <nfs_pageio_add_request>
0xffffffffc08b25a6 <nfs_do_writepage+0x146>:	test   %eax,%eax
0xffffffffc08b25a8 <nfs_do_writepage+0x148>:	jne    0xffffffffc08b268d <nfs_do_writepage+0x22d>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 646
0xffffffffc08b25ae <nfs_do_writepage+0x14e>:	mov    0x24(%r12),%r14d
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/internal.h: 757
0xffffffffc08b25b3 <nfs_do_writepage+0x153>:	cmp    $0xffffffe5,%r14d
0xffffffffc08b25b7 <nfs_do_writepage+0x157>:	jg     0xffffffffc08b2653 <nfs_do_writepage+0x1f3>
0xffffffffc08b25bd <nfs_do_writepage+0x15d>:	cmp    $0xffffffe4,%r14d
0xffffffffc08b25c1 <nfs_do_writepage+0x161>:	jge    0xffffffffc08b25df <nfs_do_writepage+0x17f>
0xffffffffc08b25c3 <nfs_do_writepage+0x163>:	cmp    $0xffffff86,%r14d
0xffffffffc08b25c7 <nfs_do_writepage+0x167>:	je     0xffffffffc08b25df <nfs_do_writepage+0x17f>
0xffffffffc08b25c9 <nfs_do_writepage+0x169>:	jle    0xffffffffc08b2701 <nfs_do_writepage+0x2a1>
0xffffffffc08b25cf <nfs_do_writepage+0x16f>:	cmp    $0xffffff8c,%r14d
0xffffffffc08b25d3 <nfs_do_writepage+0x173>:	je     0xffffffffc08b25df <nfs_do_writepage+0x17f>
0xffffffffc08b25d5 <nfs_do_writepage+0x175>:	cmp    $0xffffffe2,%r14d
0xffffffffc08b25d9 <nfs_do_writepage+0x179>:	jne    0xffffffffc08b2669 <nfs_do_writepage+0x209>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 651
0xffffffffc08b25df <nfs_do_writepage+0x17f>:	mov    0x18(%rbp),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/internal.h: 775
0xffffffffc08b25e3 <nfs_do_writepage+0x183>:	mov    %r14d,0x60(%rax)
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 71
0xffffffffc08b25e7 <nfs_do_writepage+0x187>:	lock orb $0x1,0x58(%rax)
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 652
0xffffffffc08b25ec <nfs_do_writepage+0x18c>:	mov    %r14d,%edi
0xffffffffc08b25ef <nfs_do_writepage+0x18f>:	callq  0xffffffffc08b10f0 <nfs_error_is_fatal_on_server>
0xffffffffc08b25f4 <nfs_do_writepage+0x194>:	test   %al,%al
0xffffffffc08b25f6 <nfs_do_writepage+0x196>:	jne    0xffffffffc08b2614 <nfs_do_writepage+0x1b4>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 656
0xffffffffc08b25f8 <nfs_do_writepage+0x198>:	mov    %rbp,%rdi
0xffffffffc08b25fb <nfs_do_writepage+0x19b>:	callq  0xffffffffc08b1540 <nfs_redirty_request>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 674
0xffffffffc08b2600 <nfs_do_writepage+0x1a0>:	cmp    $0xfffffff5,%r14d
0xffffffffc08b2604 <nfs_do_writepage+0x1a4>:	je     0xffffffffc08b2671 <nfs_do_writepage+0x211>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 679
0xffffffffc08b2606 <nfs_do_writepage+0x1a6>:	pop    %rbx
0xffffffffc08b2607 <nfs_do_writepage+0x1a7>:	mov    %r14d,%eax
0xffffffffc08b260a <nfs_do_writepage+0x1aa>:	pop    %rbp
0xffffffffc08b260b <nfs_do_writepage+0x1ab>:	pop    %r12
0xffffffffc08b260d <nfs_do_writepage+0x1ad>:	pop    %r13
0xffffffffc08b260f <nfs_do_writepage+0x1af>:	pop    %r14
0xffffffffc08b2611 <nfs_do_writepage+0x1b1>:	pop    %r15
0xffffffffc08b2613 <nfs_do_writepage+0x1b3>:	retq   
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 663
0xffffffffc08b2614 <nfs_do_writepage+0x1b4>:	mov    %rbp,%rdi
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 664
0xffffffffc08b2617 <nfs_do_writepage+0x1b7>:	xor    %r14d,%r14d
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 663
0xffffffffc08b261a <nfs_do_writepage+0x1ba>:	callq  0xffffffffc08b1580 <nfs_write_error_remove_page>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 679
0xffffffffc08b261f <nfs_do_writepage+0x1bf>:	mov    %r14d,%eax
0xffffffffc08b2622 <nfs_do_writepage+0x1c2>:	pop    %rbx
0xffffffffc08b2623 <nfs_do_writepage+0x1c3>:	pop    %rbp
0xffffffffc08b2624 <nfs_do_writepage+0x1c4>:	pop    %r12
0xffffffffc08b2626 <nfs_do_writepage+0x1c6>:	pop    %r13
0xffffffffc08b2628 <nfs_do_writepage+0x1c8>:	pop    %r14
0xffffffffc08b262a <nfs_do_writepage+0x1ca>:	pop    %r15
0xffffffffc08b262c <nfs_do_writepage+0x1cc>:	retq   
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 318
0xffffffffc08b262d <nfs_do_writepage+0x1cd>:	mov    (%rax),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 340
0xffffffffc08b2630 <nfs_do_writepage+0x1d0>:	test   $0x2,%ah
0xffffffffc08b2633 <nfs_do_writepage+0x1d3>:	je     0xffffffffc08b2509 <nfs_do_writepage+0xa9>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/mm.h: 1240
0xffffffffc08b2639 <nfs_do_writepage+0x1d9>:	mov    %rbx,%rdi
0xffffffffc08b263c <nfs_do_writepage+0x1dc>:	callq  0xffffffffb8e74e90 <__page_file_mapping>
0xffffffffc08b2641 <nfs_do_writepage+0x1e1>:	jmpq   0xffffffffc08b250d <nfs_do_writepage+0xad>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/mm.h: 1254
0xffffffffc08b2646 <nfs_do_writepage+0x1e6>:	callq  0xffffffffb8e74ec0 <__page_file_index>
0xffffffffc08b264b <nfs_do_writepage+0x1eb>:	mov    %rax,%rsi
0xffffffffc08b264e <nfs_do_writepage+0x1ee>:	jmpq   0xffffffffc08b24b1 <nfs_do_writepage+0x51>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/internal.h: 757
0xffffffffc08b2653 <nfs_do_writepage+0x1f3>:	cmp    $0xfffffff9,%r14d
0xffffffffc08b2657 <nfs_do_writepage+0x1f7>:	je     0xffffffffc08b25df <nfs_do_writepage+0x17f>
0xffffffffc08b2659 <nfs_do_writepage+0x1f9>:	cmp    $0xfffffffb,%r14d
0xffffffffc08b265d <nfs_do_writepage+0x1fd>:	je     0xffffffffc08b25df <nfs_do_writepage+0x17f>
0xffffffffc08b265f <nfs_do_writepage+0x1ff>:	cmp    $0xfffffff3,%r14d
0xffffffffc08b2663 <nfs_do_writepage+0x203>:	je     0xffffffffc08b25df <nfs_do_writepage+0x17f>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 656
0xffffffffc08b2669 <nfs_do_writepage+0x209>:	mov    %rbp,%rdi
0xffffffffc08b266c <nfs_do_writepage+0x20c>:	callq  0xffffffffc08b1540 <nfs_redirty_request>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 675
0xffffffffc08b2671 <nfs_do_writepage+0x211>:	mov    %rbx,%rsi
0xffffffffc08b2674 <nfs_do_writepage+0x214>:	mov    %r13,%rdi
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 676
0xffffffffc08b2677 <nfs_do_writepage+0x217>:	xor    %r14d,%r14d
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 675
0xffffffffc08b267a <nfs_do_writepage+0x21a>:	callq  0xffffffffb8e269f0 <redirty_page_for_writepage>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 679
0xffffffffc08b267f <nfs_do_writepage+0x21f>:	mov    %r14d,%eax
0xffffffffc08b2682 <nfs_do_writepage+0x222>:	pop    %rbx
0xffffffffc08b2683 <nfs_do_writepage+0x223>:	pop    %rbp
0xffffffffc08b2684 <nfs_do_writepage+0x224>:	pop    %r12
0xffffffffc08b2686 <nfs_do_writepage+0x226>:	pop    %r13
0xffffffffc08b2688 <nfs_do_writepage+0x228>:	pop    %r14
0xffffffffc08b268a <nfs_do_writepage+0x22a>:	pop    %r15
0xffffffffc08b268c <nfs_do_writepage+0x22c>:	retq   
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/compiler.h: 223
0xffffffffc08b268d <nfs_do_writepage+0x22d>:	mov    0x8(%rbx),%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 145
0xffffffffc08b2691 <nfs_do_writepage+0x231>:	lea    -0x1(%rdx),%rax
0xffffffffc08b2695 <nfs_do_writepage+0x235>:	and    $0x1,%edx
0xffffffffc08b2698 <nfs_do_writepage+0x238>:	cmove  %rbx,%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/compiler.h: 223
0xffffffffc08b269c <nfs_do_writepage+0x23c>:	mov    0x8(%rax),%rcx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 145
0xffffffffc08b26a0 <nfs_do_writepage+0x240>:	lea    -0x1(%rcx),%rdx
0xffffffffc08b26a4 <nfs_do_writepage+0x244>:	and    $0x1,%ecx
0xffffffffc08b26a7 <nfs_do_writepage+0x247>:	cmove  %rax,%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 318
0xffffffffc08b26ab <nfs_do_writepage+0x24b>:	mov    (%rdx),%rdx
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 340
0xffffffffc08b26ae <nfs_do_writepage+0x24e>:	test   $0x40000,%edx
0xffffffffc08b26b4 <nfs_do_writepage+0x254>:	je     0xffffffffc08b26c8 <nfs_do_writepage+0x268>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./arch/x86/include/asm/bitops.h: 318
0xffffffffc08b26b6 <nfs_do_writepage+0x256>:	mov    (%rax),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/page-flags.h: 340
0xffffffffc08b26b9 <nfs_do_writepage+0x259>:	test   $0x2,%ah
0xffffffffc08b26bc <nfs_do_writepage+0x25c>:	je     0xffffffffc08b26c8 <nfs_do_writepage+0x268>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/mm.h: 1240
0xffffffffc08b26be <nfs_do_writepage+0x25e>:	mov    %rbx,%rdi
0xffffffffc08b26c1 <nfs_do_writepage+0x261>:	callq  0xffffffffb8e74e90 <__page_file_mapping>
0xffffffffc08b26c6 <nfs_do_writepage+0x266>:	jmp    0xffffffffc08b26cc <nfs_do_writepage+0x26c>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/mm.h: 1242
0xffffffffc08b26c8 <nfs_do_writepage+0x268>:	mov    0x18(%rbx),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/iostat.h: 42
0xffffffffc08b26cc <nfs_do_writepage+0x26c>:	mov    (%rax),%rax
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 644
0xffffffffc08b26cf <nfs_do_writepage+0x26f>:	xor    %r14d,%r14d
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/iostat.h: 42
0xffffffffc08b26d2 <nfs_do_writepage+0x272>:	mov    0x28(%rax),%rax
0xffffffffc08b26d6 <nfs_do_writepage+0x276>:	mov    0x400(%rax),%rax
0xffffffffc08b26dd <nfs_do_writepage+0x27d>:	mov    0x40(%rax),%rax
0xffffffffc08b26e1 <nfs_do_writepage+0x281>:	incq   %gs:0x38(%rax)
0xffffffffc08b26e6 <nfs_do_writepage+0x286>:	jmpq   0xffffffffc08b2606 <nfs_do_writepage+0x1a6>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 632
0xffffffffc08b26eb <nfs_do_writepage+0x28b>:	mov    %eax,%r14d
0xffffffffc08b26ee <nfs_do_writepage+0x28e>:	jmpq   0xffffffffc08b2600 <nfs_do_writepage+0x1a0>
0xffffffffc08b26f3 <nfs_do_writepage+0x293>:	ud2    
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 637
0xffffffffc08b26f5 <nfs_do_writepage+0x295>:	jmpq   0xffffffffc08b258b <nfs_do_writepage+0x12b>
0xffffffffc08b26fa <nfs_do_writepage+0x29a>:	ud2    
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/write.c: 347
0xffffffffc08b26fc <nfs_do_writepage+0x29c>:	jmpq   0xffffffffc08b252d <nfs_do_writepage+0xcd>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/fs/nfs/internal.h: 757
0xffffffffc08b2701 <nfs_do_writepage+0x2a1>:	cmp    $0xfffffe00,%r14d
0xffffffffc08b2708 <nfs_do_writepage+0x2a8>:	jne    0xffffffffc08b2669 <nfs_do_writepage+0x209>
0xffffffffc08b270e <nfs_do_writepage+0x2ae>:	jmpq   0xffffffffc08b25df <nfs_do_writepage+0x17f>
/usr/src/debug/kernel-4.19.90/linux-4.19.90-23.16.v2101.ky10.x86_64/./include/linux/backing-dev.h: 166
0xffffffffc08b2713 <nfs_do_writepage+0x2b3>:	mov    %r15,%rdi
0xffffffffc08b2716 <nfs_do_writepage+0x2b6>:	callq  0xffffffffb8f06950 <I_BDEV>
0xffffffffc08b271b <nfs_do_writepage+0x2bb>:	mov    0x98(%rax),%rax
0xffffffffc08b2722 <nfs_do_writepage+0x2c2>:	jmpq   0xffffffffc08b2571 <nfs_do_writepage+0x111>
```

