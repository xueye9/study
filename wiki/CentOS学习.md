# CentOS7学习

## 详细目录说明

 参考网址 [详细目录说明](https://meetes.top/2018/08/05/CentOS7%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84%E8%AF%A6%E7%BB%86%E7%89%88/)
 
## 最小安装开启网络

打开如下文件,注意"eth"后的数字是用ip addr命令查看的网卡的编号


vi /etc/sysconfig/network-scripts/ifcfg-eth0

```
BOOTPROTO=dhcp
ONBOOT=yes
```

保存退出后启动服务

```
service network start 
```

