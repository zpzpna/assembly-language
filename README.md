# assembly-language
练习自汇编语言王爽（第四版）

----

**.asm** 代码,	**.obj** 未链接的可重定位目标文件	，**.exe**链接后可运行的程序

---

**tools使用方法：**

1. 由于debug在win10以上版本不能使用，需要下载一个**dosbox**，用来模拟运行8086虚拟环境。

   首先要mount挂在代码仓库到任意一个盘符，例如，我的本地仓库assembly-language放在d盘，于是将他挂到c盘存储节点，此时模拟器中转c盘直接是代码仓库目录

   `mount c d:\assembly-language`

   `cd c`

   接着进入**tools**目录下从而使用工具

   `cd tools`

2. 然后在命令行使用**masm**编译代码目录下的xxx.asm，得到xxx.obj

   `masm` ..\code\xxx;

3. 接着命令行中使用**link**进行链接，得到xxx.exe

   `link xxx;`

4. 注意不可以在本地直接双击xxx.exe执行，需要在虚拟环境命令行中输入xxx.exe执行或者用debug查看

   debug查看：`debug xxx.exe`

   直接执行：`xxx.exe`

​	(注意编译链接执行选择的文件使用的路径，要进行调整)

---

**labxx-nn含义：**

xx代表第xx号实验，

nn中，后一个n代表实验的第几个任务，前一个n代表是不是部分实验任务所有的测试代码

如lab13-03和lab13-13，前者是安装中断例程的代码，后者是安装后测试终端例程的代码

