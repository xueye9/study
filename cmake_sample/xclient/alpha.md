﻿#xclient
京东X事业部智能导航研发部数据存储上传下载客户端

#版本日志


1 修改dataset构造函数，解决添加数据集状态不正确的问题；

##Version 2.0.0_20180528_Alpha
1 新增虚拟登录机制；
2 新增新建库和删除库功能；
3 修改addTank的坐标提取规则从搜索到的第一个文件，所有txt文件范围的最大范围；
4 完善日志；
5 修复若干bug；
6 惯导文件认定规则修改为文件第一行不能为空，且以‘,’分割的第一个内容必须是 $GPFPD ；

##Version 0.0.1_20180326_Alpha 
1 重构工作空间持久化相关代码, 工作空间文件变为单个文件；
2 文件上传过程中实时保存工作空间内容；
3 丰富文件状态；
4 优化上传过程的中的断点续传处理逻辑，将上传状态保存在本地，解决检查上传状态时间过长的问题；
5 新增文件和数据集信息提取的插件机制同时实现了图像文件和bag文件的生产时间信息提取插件；

##Version 0.0.1_20180307_Alpha
1 修复上传、下载时间统计一分钟以上秒值显示不正确的问题
2 界面显示优化；
3 新增修改工作空间功能;
4 修复上传文件计数问题；
5 修复多线程资源抢占问题；
6 数据集窗口新增取消按钮逻辑的实现，解决不设置数据集取消按钮中断的bug
7 取消窗口?号按钮;

##Version 0.0.1_2018022602_Alpha
1 修复addTank上传时间值为0的问题；

##Version 0.0.1_20180226_Alpha
1 修复多线程锁bug；
2 修复提前提示完成bug；
3 修改提示上传覆盖原则时机；
4 新增显示数据集文件数量；

##Version 0.0.1_20180213_Alpha
1 新增上传文件为异步多线程方式；
2 新增停止上传功能;
3 新增控制认定大文件配置;
4 修复保存中文工作空间可能出现乱码的bug;
5 修复界面树控件上传完成状态刷新bug；
6 优化加载和验证配置文件逻辑;
7 优化上传进度显示；
8 优化树控件状态内容显示;

##Version 0.0.1_20180206_Alpha
1 增加下载数据集和下载文件的功能，注意如果数据集文件很多的情况下（上万），可能因为寻找目录结构造成初始化下载信息卡顿,可以考虑在现在的数据结构上增加根目录信息解决; 

##Version 0.0.1_20180201_Alpha
1 增加上传文件夹的功能；
2 增加中文路径支持;

##Version 0.0.1_20170119_Alpha
1 展示时间使用本地时间展示；

##Version 0.0.1_20170117_Alpha
1 添加文件、数据集对话框默认时间修改为当前时间；
2 优化界面控制；

##Version 0.0.1_20170115_Alpha
1 修复数据集导入的惯导文件格式不正确程序闪退的bug;
2 新增界面控制，在同一个工作空间中不能添加同名文件或同名数据集;

##Version 0.0.1_20170105_Alpha
1 断点续传功能进度相关调整；
2 增加最近上传速度相关判断，以解决大文件网络中断程序阻塞的隐患解决；

##Version 0.0.1_20171228_Alpha
1 增加提取生产起始和结束时间功能；
2 优化设置服务地址功能的提示；

##Version 0.0.1_20171227_Alpha
1 新增保存设置服务地址功能；
2 新增从中间惯导文件提取坐标范围功能；

##Version 0.0.1_201712262_Alpha
1 新增批量添加文件功能；

##Version 0.0.1_20171226_Alpha
1 增加记录出错日志功能；
2 修复新建工作空间崩溃的bug;
3 完善删除文件和数据集功能（暂不支持删除数据集中的文件）；
4 增加上传空间数据集功能；
5 界面控制相关优化；

##Version 0.0.1_20171219_Alpha
1 基础功能
