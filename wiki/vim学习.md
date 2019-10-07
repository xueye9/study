#vim学习

##make主题

设置makeprg,即设置make命令和参数，eg：

目录结构如下：
test-
    build-
        Makefile 
    src-
        main.cc

在用vim编辑main.cc时要编译程序
需要设置makeprg参数
:set makeprg=make\ --directory=../build

**不要用-f指定编译文件 ，因为找不到其他的输出目录

