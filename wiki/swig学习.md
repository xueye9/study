#swig学习 

##安装

###Unix

####简单安装
默认安装到 /usr/local
```
$./configure
$make
$make install 
```

####指定安装目录
```
$./configure --prefix=/home/xuebb/projects
$make
$make install
```

###Windows
直接下载可运行的二进制包即可

####

##c++ 封装 python
    执行命令:
```
    swig -c++ -python -o ../../xdata/xdata_wrap.cxx -outdir c:\OSGeo4W64\apps\Python27\lib xdata.i
```

* -c++     输入时c++
* -python  输出时python
* -o ***    指定生成的c++文件,c++是.cxx,c是.c
* -outdir 指定python文件输出位置
* 最后跟随模块定义文件, 后缀名名为 .i 或 .swig

###模块文件说明

```
    %module xdata
    %include <std_string.i>
    %include <std_shared_ptr.i>
    %include <cpointer.i>

    %pointer_class(std::string, std_string_ptr);

    %{
    #include "transferprogress.h"
    #include "position.h"
    #include "BaseDoc.h"
    #include "SpatialDoc.h"
    #include "FileDoc.h"
    #include "DataSetDoc.h"
    #include "indexclient.h"
    #include "storeclient.h"
    #include "library_config.h"
    #include "factory.h"
    %}

    %shared_ptr(xdata::Position)
    %shared_ptr(xdata::BaseDoc)
    %shared_ptr(xdata::SpatialDoc)
    %shared_ptr(xdata::FileDoc)
    %shared_ptr(xdata::DataSetDoc)

    %include "transferprogress.h"
    %include "position.h"
    %include "BaseDoc.h"
    %include "SpatialDoc.h"
    %include "FileDoc.h"
    %include "DataSetDoc.h"
    %include "indexclient.h"
    %include "storeclient.h"
    %include "library_config.h"
    %include "factory.h"
```

* %module  指定模块名称,生成的python文件名就是此命令指定的名字
* %{ %} 包含的会原封不动的赋值的 c 或 cxx文件中
* %include 指定包含的声明文件,和c/c++的 #include 不同的是不会展开#include
* %include <std_shared_ptr.i> 使用swig支持的std的share_ptr 此外还支持boost
的share_ptr,注意:声明的只能指针的类型要包含完整的命名空间(如果有的话,第一次
封装的时候就吃了这个亏)

另外的说明: %include的文件和原始的头文件会有一定的不同:
* 需要删除库的导入导出 符的宏
* 如果用宏出来的类名或模板名字,那么需要将宏替换为类名或原始模板名
* c++声明的常量不能包含到 .i文件中,具体原因不明,反正包含了就编译不过
* 将修改过的 .h 文件放在 .i 文件目录下的 swig_lib目录下, 因为swig默认扫描的目录为
    * 当前目录
    * 使用 -I 指定的目录
    * ./swig_lib
    * SWIG library install location as reported by swig -swiglib, for example /usr/local/share/swig/1.3.30
    * 在windows下swig.exe当前下的Lib目录


###使用
1. 将生成的 .c/.cxx文件和原库文件一起编译,编译时需要python-devel的支持需要包含 python安装目录下 include/Python.h,
连接libs/python27.lib(27需要替换成你使用的python的版本号)
2. 在windows下将编译的 [module].dll 改名问 _[module].pyd 拷贝到 python安装目录下的 DLLs 目录下,如果有依赖库一起拷贝到该目录(不用修改
 依赖库的后缀名),将生成的 [module].py开包的python安装目录下的Lib目录下,安装完成
 
###Linux
    在centos7下做的实验(编译器版本gcc4.8)
    
####编译库
    使用cmake生成 Makefile 文件,进行编译,swig命令和windows下执行的类似,连接的python库和Python.h头文件和机器安装的python相关.
    
####安装库
    将生成的 module.py 文件拷贝到 /usr/lib64/python2.7/ 目录下(我的系统是64位的), 将生成的 lib[module].so 文件使用 
    ln -sf lib[module].so _[module].so 生成软连接,然后在此文件夹下 
    $python  
    >>>import [module]   
    如果不报错说明已经安装成功了
    
    
    
