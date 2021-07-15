=========================
fdcan 精简code size笔记
=========================

loader使用必须精简
-------------------------
1. cubemx原生占用2.5k左右
2. 精简后大约0.6k驱动代码 只支持classic can


fdcan 初始化
-------------------------
1. 设置CCCR寄存器 推出sleep 进入init
2. 记得初始化gpio rcc can clock
3. 初始化clk-div = 0
4. 设置fdcan frame format、ops mode、txfifo mode
5. fdcan 专用ram初始化
6. 离开初始化模式，
7. 使能tx rx中断，使能中断线0/1 
8. 初始化中断线分别对应的3个FIFO中断TXBTIE
9. 使能nvic


fdcan 专用ram
-------------------------
1. 这个ram用于滤波器，接收fifo0、1 发送fifo的存储
2. 初始化时将这个ram清0
3. 将ram分块后，计算好各块的起始地址到结构体保存

fdcan 发送
-------------------------
1. 根据txfifo状态 TXFQS 获取当前哪个fifo空闲，（最多存放3个）
2. 将要发送的数据txheader + txdata复制到txfifo对应的index里
3. TXBAR寄存器写入index可以启动发送

fdcan 接收
-------------------------
1. 我们使用中断模式接收。可以不设置滤波器 也可以接收
2. 使能RX中断new-msg， 新消息触发中断
3. 中断检查对应标志位，然后根据rx fifo index（RXF0S状态寄存器指示）
4. 将消息从专用ram中复制出来获得header和data