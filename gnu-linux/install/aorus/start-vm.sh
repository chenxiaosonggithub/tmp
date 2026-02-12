# virsh list # 本地活动虚拟机
virsh list --all # 本地所有的虚拟机（活动的+不活动的）
# virsh shutdown Win11_24H2_Chinese_Simplified_x64 # 正常关闭虚拟机
# virsh destroy Win11_24H2_Chinese_Simplified_x64 # 强制关闭虚拟机
virsh start Win11_24H2_Chinese_Simplified_x64 # 启动非活动虚拟机
