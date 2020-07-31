# CentOS 磁盘合并

```shell
df -Th
fdisk -l
fdisk /dev/sda
df -hal
df -Th
mkfs.ext4 /dev/sda1 

pvcreate /dev/sda1 
lvdisplay
vgextend centos /dev/sda1 
vgdisplay
lvresize -L +9.5G /dev/centos/home
resize2fs /dev/centos/root ## 无效的话采用: `xfs_growfs /dev/centos/root`
df -hal
reboot
```
## 对磁盘进行分区格式化
`df -TH`   查看磁盘大小

`fdisk -l` 查看机器所挂硬盘个数及分区情况

`fdisk /dev/sda` 对数据盘进行分区。根据提示，依次输入 `n`，`p`，`1`，两次回车，`w`，分区就开始了。

`mkfs.ext4 /dev/sda1` 格式化分区为ext4

如果之前格式化过磁盘并挂载过,只需要取消挂载就行,不需要进行以上步骤.

附取消挂载方法

打开 `/etc/fstab` 删除对应的挂载语句即可,然后reboot

## 把分区合并到系统盘

`pvcreate /dev/sda1` 创建物理卷

`lvdisplay` 显示逻辑卷属性,记住这里看到的VG Name 和 LV Name

`vgextend centos /dev/sda1` 将创建的物理卷加入到准备合并的磁盘所在的VG Name的组中,这里是centos

`vgdisplay` 显示LVM卷组的信息(查看物理卷及空间情况)

`lvresize -L +9.5G /dev/centos/root`  调整逻辑卷空间大小,其中路径中的centos是VG Name,root是LV Name,上面lvdisplay命令获取到的信息,这里的9.5G大小是/dev/sda1的大小9.8G的一部分,不要全部用完.
PS: 

`resize2fs /dev/centos/root` (或者`xfs_growfs /dev/centos/root`)  动态扩容分区大小,如果resize2fs命令失败,请使用xfs_growfs

`df -hal`

 
`reboot`

如果没出错,就可以看到磁盘合并的效果了.

