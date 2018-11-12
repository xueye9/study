#
次文件夹是存放vim配置文件的,放在用户家(~)目录下,实现了部分不同平台的区分;
.vim是存放插件的linux配置文件的地方;vimfiles是为了在win下自动启动plug管理插件的插件的;

#windows安装
使用 命令 MKLINK ~/.vimrc 绝对路径的本文件夹下的 .vimrc
将文件夹.vim和vimfiles拷贝到 ~/下即可


##关于ycm插件
在win平台下使用osgeo4w的环境编译和安装时可以的; [.vim]目录下有win平台的语法补全配置文件
值需要python3的相关环境,所以在环境变量中设置可以找到python3的环境变量也是可以的

