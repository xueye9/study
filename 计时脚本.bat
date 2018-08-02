@echo start at: [%date%][%time%]

@set local_file="D:\cmake-3.12.0.tar.gz"

@echo pushing file ...
@curl -i -H "Content-Type: application/octet-stream" -X PUT -T %local_file% "http://192.168.178.55:14000/webhdfs/v1/zhangyu85/cmake-3.12.0.tar.gz?op=CREATE&data=true&recursive=true&user.name=spark"

@echo off 
::每5分钟复制以下首页
for /f %%i in ('dir /b %local_file%') do (
 echo %%~zi bytes
)
::if %indexdx% gtr 5120 (
::echo y | xcopy c:\index2.htm /d /r /k c:\index.htm
::)

@echo end at: [%date%][%time%]
@pause