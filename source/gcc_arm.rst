============================
gcc-arm tutorial
============================


什么是GCC？
------------------
gcc是GNU开源社区的一套编译工具链简称 Gnu Compiler Collection
for C, C++, Objective-C, Fortran, Ada, Go, and D, as well as libraries for these languages (libstdc++,...).
也支持多平台win32/amd64/LINUX/macos等。 
是开放源代码的自由软件，无license需求，无法律风险。

什么是GCC-ARM ?
------------------
用于交叉编译运行在arm上的固件所用的编译器。
同理 keil使用的编译器是ARMCC和ARMCLANG（也叫AC6)

=============== ===============  ==================== =================
compiler        gcc_arm          armclang             armcc(将来会废弃）
=============== ===============  ==================== =================
使用许可         商用免费          需要license          需要license
编译速度         非常快            非常快               慢
跨平台           win/linux/mac    win                  win
生成固件         较大              较小                 较小
建议场景         绝大部分应用       flash紧张            不建议使用
=============== ===============  ==================== =================

.. tip:: 总结：新工程都优先使用gcc_arm，开放灵活免费。
.. tip:: 如果必须使用keil，则使用armclang (keil里option--target--code-generation选择AC6）

开始搭建环境
---------------------------
方案 vscode + make + gcc-arm + (ozone/jscope/。。非必需）
其中vscode作为编辑器
make用于全局编译构建，处理依赖关系，编译参数，生成elf以及bin等
gcc-arm作为交叉编译器

安装vscode
-------------------------
下载安装vscode.  安装扩展c/c++(microsoft)   cortex-debug （已放在网盘（Y:\公用工程软件\）

.. image:: imgs/gcc/11.png
    :scale: 100%

安装gcc-arm
-------------------------
#. 安装gcc-arm-none-eabi-win32.exe（已放在网盘（Y:\公用工程软件\）
安装路径选择 X:\gnu_arm_embedded 并且添加X:\gnu_arm_embedded\bin到系统变量path（如果有选项勾选添加到环境变量就不需要这一步）

.. image:: imgs/gcc/env-gcc.png
    :scale: 100%

安装choco 与 make
------------------------
开始-输入powershell 管理员开powershell 复制以下  回车。

.. image:: imgs/gcc/ps.png
    :scale: 100%

::

    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


::

    choco -v    #查看安装choco成功
    choco feature enable -n allowGlobalConfirmation
    choco install make
    make -v     #查看安装make 可能需要重新启动命令行才可以运行



.. image:: imgs/gcc/chocoall2.png
    :scale: 100%

安装jlink与添加环境变量
------------------------
.. image:: imgs/gcc/env.png
    :scale: 100%
.. image:: imgs/gcc/env2.png
    :scale: 100%
.. image:: imgs/gcc/env-jlink.png

打开命令行 输入jlink回车 没报错说明安装ok


编译所需准备的文件
----------------------
1. Makefile (整个工程哪些东西参与编译，头文件路径、链接哪些库、优化调试的选项开关控制等）同时也是make命令的input
2. startup_stm32h750xx.s (mcu的gcc启动头文件 主要是中断向量表，复制有初始值到ram，c环境准备等， 与keil类似但不通用 ）
3. STM32H750VBTx_FLASH.ld (mcu的gcc 链接文件 包含了mcu的ram和flash布局 堆栈大小设置。 keil里对应sct文件）
4. main.c 和其他所有的.c/.h文件


编译流程简介
-------------------------
1. 预处理（头文件展开 宏展开、替换） 将所有的#include头文件以及宏定义替换成其真正的内容
2. 编译
3. 汇编 得到一堆*.o 也叫目标文件
4. 链接 （将.o文件组装成可执行文件elf，里面包含调试信息。可生成二进制文件给mcu执行）