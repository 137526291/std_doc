=========================
vscode 的配置文件
=========================

所有vscode配置文件放在工程目录/.vscode/xxx.json

launch.json 
--------------------
1. 该文件放在工程目录/.vscode/launch.json
2. vscode的Run-Add Configuration 添加cortex debug可以生成模板
#. F5启动调试的时候，launch.json文件用来配置如下
#. 使用什么调试器jlink/xlink,
#. device是mcu型号
#. executable是要编译后生成的调试的elf文件
#. serialNumber可以指定jlink 用于多个jlink调试时


::

    {
        "version": "0.2.0",
        "configurations": [
            {
                "cwd": "${workspaceRoot}",
                "executable": "./build/${workspaceRootFolderName}.elf",
                "name": "Debug mcu",
                "request": "launch",
                "type": "cortex-debug",
                "servertype": "jlink",
                "device":"STM32F303RC",
                // "serialNumber": "13526291", 
                "svdFile": "STM32F303xx.svd"
                //"preLaunchTask": "build"
            }
            
        ]
    }


tasks.json
-------------------------
该文件配置了默认的编译任务 也可以扩展更多的任务
ctrl + shift + B会编译默认任务（也就是make -j)

::

    {
        "version": "2.0.0",
        "tasks": [
            {
                "type": "shell",
                "label": "build",
                "command": "make",
                "args": [
                    "-j"
                ],
                "options": {
                    "cwd": "${workspaceFolder}"
                },
                "problemMatcher": [
                    "$gcc"
                ],
                "group": {
                    "kind": "build",
                    "isDefault": true
                }
            }
        ]
    }


c_cpp_properties.json
-------------------------
该文件用于智能联想代码补全 vscode会在当前工程索引所有c/h文件 帮你编程时补全
当遇到有些发现没定义的符号时，会有波浪线 旁边有个小灯泡，点击灯泡后可以生成该配置模板
另外是makefile里定义的一些宏，例如

::

    C_DEFS =  \
    -DUSE_HAL_DRIVER \
    -DSTM32F303xE
则不会被vscode识别，所以要在该文件中显示声明

::

    {
        "configurations": [
            {
                "name": "gdb",
                "includePath": [
                    "${workspaceFolder}/**"
                ],
                "intelliSenseMode": "${default}",
                "compilerPath": "C:\\gnu_arm_embedded\\bin\\arm-none-eabi-gcc.exe",
                "cStandard": "c11",
                "cppStandard": "c++17",
                "defines": [
                    "USE_FULL_LL_DRIVER",
                    "USE_HAL_DRIVER",
                    "STM32F303xE"
                ]
            }
        ],
        "version": 4
    }