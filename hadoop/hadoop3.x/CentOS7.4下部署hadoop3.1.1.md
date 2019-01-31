# CentOS7.4下部署hadoop3.1.1

##契机
由于工作原因要部署hadoop的集群,习惯使用最新的稳定版本2018年的时候由于时间紧破部署了2.7.2版本,最新由于又要部署有研究了一下3.x的部署.这次
研究通了,在这里记录一下,防止以往.

本次部署的是一个可用的集群,不是高可用的,因为高可用的hadoop还要部署zookeeper和ha,搞可用的hadoop以后有需要再研究.

##准备工作
###规划

####软件

| 软件          | 版本      | 位数  | 说明     |   
|---------------|-----------|-------|----------|
| Jdk           | Jdk1.8    | 64位  | 稳定版本 |   
| Centos        | Centos7.4 | 64位  | 稳定版本 |   
| Hadoop        | Hadoop    | 3.1.1 | 最新版本 |   
| ~~Zookeeper~~ | Zookeeper | 3.4.6 | 稳定版本 |   |
    
####数据目录

| 目录名称         | 绝对路径            |
|------------------|---------------------|
| 目录名称         | 绝对路径            |
| 所有软件存放目录 | /home/hadoop3/app   |
| datanode目录     | /home/hadoop3/data  |
| namenode目录     | /home/hadoop3/name  |
| tmp目录          | /home/hadoop3/tmp   |
| jdk目录          | /usr/local/opt/java |

###关闭防火墙

* systemctl stop    firewalld -> 关闭防火墙
* systemctl disable firewalld -> 开机不启动防火墙
* systemctl status  firewalld -> 开机不启动防火墙 

###关闭selinux
打开文件/etc/selinux/config,修改文件内容
    
    SELinux=enforing -> SELINUX=disabled 
    
###开启ntp 时间同步服务

* systemctl stop ntpd

    如果是在局域网内可以用一台机器为时间同步的主服务器,其他机器使用主服务的时间同步本机时间,设置方法参考下文
    
###新建账户
通常由于安全的考虑我们不会把hadoop部署到root账户下,新建用户名为hadoop3的用户

* adduser hadoop3 ->新增用户
* passwd hadoop3  ->设置hadoop3的用户密码
* groupmod -g 2000 hadoop3 -> adduser命令会新增同名group,更改所有集群hadoop3组的groupid为一样的值

##修改机器名
以namenode的机器为例

使用hostnamectl -set-hostname m1.hadoop

修改 /etc/hosts 增加

    x.x.x.1 m1.hadoop m1
    x.x.x.1 s1.hadoop s1
    x.x.x.1 s2.hadoop s2 

修改 /etc/sysconfig/network

    NETWORKING=yes
    HOSTNAME=m1.hadoop  
    
##ssh免密登录
在hadoop3账户下
    
* ssh-keygen 生成公钥和私钥过程中需要敲两次Enter,不要要输入任何内容
* ssh-copy-id hadoop3@x.x.x.x
* 选一台机器,所有其他节点声场秘钥后用ssh-copy-id将公钥拷贝到这台机器
* 使用 scp /home/hadoop3/.ssh/authoried_keys hadoop3@x.x.x.x:/home/hadoop3/.ssh/ 将记录公钥的文件拷贝的所有节点,这样所有节点都配置好免密登录了

##ntp局域网时间同步

参考地址: http://blog.51cto.com/xu20cn/69689

假定时钟服务器IP地址为：192.168.0.1

###服务器端配置

1. 置/etc/ntp.conf文件内容为：
    
    server 127.127.1.0 minpoll 4
    fudge 127.127.1.0 stratum 1
    restrict 127.0.0.1
    restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap
    driftfile /var/lib/ntp/drift

2. /etc/ntp/ntpservers应置空
3. /etc/ntp/step-tickers应配置为 127.127.1.0 
上述修改完成后，以root用户身份重启ntpd服务:systemctl restart ntpd 即可

###客户端配置

1. 置/etc/ntp.conf文件内容为：
    
    server 192.168.0.1
    fudge 127.127.1.0 stratum 2
    restrict 127.0.0.1
    driftfile /var/lib/ntp/drift
    restrict 192.168.0.1 mask 255.255.255.255
    
2. /etc/ntp/ntpservers 文件内容置空
3. /etc/ntp/step-tickers文件内容置为时钟服务器IP地址 192.168.0.1
上诉修改完成后，以root用户身份重启ntpd服务:systemctl restart ntpd 即可
用户可用以下两个常用命令查看ntpd服务状态：
1 ntpq -p
2 ntpstat 

linux下ntpd安装配置笔记
概述: ntp能与互联网上的时钟保持同步,而且本身也是一台NTP服务器,可以为局域网电脑提供校对时间服务
安装: redhat自带
配置文件: /etc/ntp.conf
附:我的配置文件

    #restrict default ignore
    restrict 127.0.0.1
    restrict 192.168.3.20
    restrict 192.168.0.0 mask 255.255.255.0
    restrict 192.168.2.0 mask 255.255.255.0
    restrict 192.168.4.0 mask 255.255.255.0
    server 210.72.145.44 prefer       #National Time Service Center
    server 195.13.1.153
    server 194.137.39.67
    server 127.127.1.0     # local clock
    restrict 210.72.145.44
    restrict 195.13.1.153
    restrict 194.137.39.67
    driftfile /var/lib/ntp/drift
    
附:相关配置参数说明 
* restrict权限控制语法为：
* restrict IP mask netmask_IP parameter
    * 其中 IP 可以是软件地址，也可以是 default ，default 就类似 0.0.0.0 咯！
    * 至于 paramter 则有：
        * ignore　：关闭所有的 NTP 联机服务
        * nomodify：表示 Client 端不能更改 Server 端的时间参数，不过，
        * Client 端仍然可以透过 Server 端来进行网络校时。
        * notrust ：该 Client 除非通过认证，否则该 Client 来源将被视为不信任网域
        * noquery ：不提供 Client 端的时间查询
        * 如果 paramter 完全没有设定，那就表示该 IP (或网域) 『没有任何限制！』
* 设定上层主机主要以 server这个参数来设定，语法为：
    * server [IP|FQDN] [prefer]
    * Server 后面接的就是我们上层 Time Server 啰！而如果 Server 参数
    * 后面加上 perfer 的话，那表示我们的 NTP 主机主要以该部主机来作为
    * 时间校正的对应。另外，为了解决更新时间封包的传送延迟动作 

让FreeBSD使用ntpd同步时间
　　我们知道ntpd是一种在后台运行可以使用远程时间服务器的进程，它可以让你的服务器时间准确而不会影响系统的正常。
　　首先修改/etc/rc.conf添加ntpd_enable="YES"到最后一行。然后vi /etc/ntp.conf
添加：
server 210.72.145.44 prefer
server 159.226.154.47
server 127.127.1.0
fudge 127.127.0.1 stratum 5
restrict default ignore
restrict 127.0.0.0 mask 255.0.0.0
restrict 192.168.0.0 mask 255.255.255.0 noquery nopeer notrust
restrict 210.72.145.44 noquery
restrict 159.226.154.47 noquery
driftfile /var/db/ntpd.drift
　　其中server 210.72.145.44 prefer、server 159.226.154.47、restrict 210.72.145.44 noquery、restrict 159.226.154.47 noquery可以改成其他离你最近或最准确的时间服务器。
　　这样在服务器重启后ntpd进程就会自动在后台运行，帮助系统同步时间，和在192.168.0这个网段内做一台时间服务器。

##安装jdk
下载jdk 下载网页 https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html 安装包名字类似 jdk-8u191-linux-x64.tar.gz

##部署和分发hadoop程序
下载 hadoop-3.1.1.tar.gz 下载网页 https://hadoop.apache.org/releases.html 

使用 tar -zxvf hadoop-3.1.1.tar.gz 解压hadoop,

3.x的hdfs的默认端口号是9870和2.x的50070不同

### core-site.xml
    在hadoop解压目录 etc/hadoop/目录下
    
```xml
<configuration> 
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://m1.hadoop:9000</value>
    </property> 
    <property>
        <name>io.file.buffer.size</name>
        <value>131072</value>
    </property> 
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/home/hadoop3/tmp</value>
    </property>

    <!-- httpfs 设置-->
    <property>
        <name>hadoop.proxyuser.hadoop3.hosts</name>
        <value>*</value>
    </property>
    <property>
        <name>hadoop.proxyuser.hadoop3.groups</name>
        <value>*</value>
    </property>
</configuration> 
```

### hdfs-site.xml
    在hadoop解压目录 etc/hadoop/目录下

```xml 
<configuration> 
    <!--Configurations for NameNode-->
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/home/hadoop3/name</value>
    </property> 
    <property>
        <name>dfs.hosts</name>
        <value></value>
    </property> 
    <property>
        <name>dfs.blocksize</name>
        <value>268435456</value>
    </property>
    <property>
        <name>dfs.namenode.handler.count</name>
        <value>100</value>
    </property>

    <!--Configurations for DataNode-->
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/home/hadoop3/data</value>
    </property> 
</configuration>
```

###yarn-size.xml 
    在hadoop解压目录 etc/hadoop/目录下
    
```xml 
<configuration> 
    <!-- Site specific YARN configuration properties --> 
    <!-- Configurations for ResourceManager and NodeManager --> 
    <property>
        <name>yarn.acl.enable</name>
        <value>false</value>
    </property>
    <property>
        <name>yarn.admin.acl</name>
        <value>*</value>
    </property>
    <property>
        <name>yarn.log-aggregation-enable</name>
        <value>false</value>
    </property>

    <!--Configurations for ResourceManager-->
    <property>
        <name>yarn.resourcemanager.hostname</name>
        <value>m1.hadoop</value>
    </property>
    <property>
        <name>yarn.scheduler.class</name>
        <value>org.apache.hadoop.yarn.server.resourcemanager.scheduler.fair.FairScheduler</value>
    </property>
    <property>
        <name>yarn.scheduler.minimum-allocation-mb</name>
        <value>256</value>
    </property>
    <property>
        <name>yarn.scheduler.maximum-allocation-mb</name>
        <value>4096</value>
    </property>

    <!--Configurations for Manager-->
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
    <property>
        <name>yarn.nodemanager.env-whitelist</name>
        <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>
    <property>
        <name>yarn.nodemanager.vmem-check-enabled</name>
        <value>false</value>
    </property>
</configuration>
```
###hadoop-env.sh
修改了这个文件,就不需要修改 /etc/profile的配置文件来修改环境变量了
    在hadoop解压目录 etc/hadoop/目录下

```ini
# The java implementation to use. By default, this environment
# variable is REQUIRED on ALL platforms except OS X!
# export JAVA_HOME=
export JAVA_HOME=/usr/local/opt/java/jdk1.8.0_191

# Location of Hadoop.  By default, Hadoop will attempt to determine
# this location based upon its execution path.
# export HADOOP_HOME=
export HADOOP_HOME=/home/hadoop3/app/hadoop-3.1.1
```

##启动dfs
在hadoop的部署目录下的sbin目录执行
start-dfs.sh
    
查看dfs的状态: http://x.x.x.x:9870/

使用jps查看状态(jps需要将jdk目录设置到环境变量)

20401 SecondaryNameNode
20993 HttpFSServerWebServer
20082 NameNode
20636 ResourceManager
27533 Jps

###启动httpfs代理
在hadoop的部署目录下的sbin目录执行
httpfs.sh start 

##启动yarn
在hadoop的部署目录下的sbin目录执行
start-yarn.sh

查看yarn的状态: http://x.x.x.x:8088/

