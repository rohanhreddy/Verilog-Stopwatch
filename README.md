# Rohan H Reddy - 2024A3IS0130G

## Overview
This assignment implements a hardware-software co-design of a digital stopwatch. Verilog was primarily used to write the hardware functionality and testbench. The verilog files were compiled and simulated using Icarus Verilog and GTK Wave.

## Image Describing Connectivity
Attatched is a colour coded image describing the connectivity between modules in stopwatch_top.v

<a href="https://ibb.co/JD2pGGz"><img src="https://i.ibb.co/rDMpzzZ/image.png" alt="image" border="0" /></a>

## Build Commands

**To compile using iVerilog:** iverilog.exe -o ./icarusgtk/stopwatch_sim ./tb/tb_stopwatch.v ./rtl/stopwatch_top.v ./rtl/control_fsm.v ./rtl/seconds_counter.v ./rtl/minutes_counter.v

**To prepare for GTK Wave:** vvp.exe ./icarusgtk/stopwatch_sim
 gtkwave.exe ./icarusgtk/stopwatch_simg.vcd

**Verilator:** make


## Design Choices

All verilog files follow the description provided by the assignment and use basic storage elements, loops and conditions to accomplish the task. Every file consists of one module with always loops and if else statements or case statements to make logical decisions. The top-level module ("stopwatch_top.v") handles connectivity between modules while "control_fsm.v" mainly handles the states. Almost all logic for elements is handled in their own modules.

## Versions Of Tools Used

**Visual Studio Extensions:** WSL by Microsoft, Verilog-HDL/System Verilog/Bluespec SystemVerilog by Masahiro Hiramori

**Icarus Verilog:** v12-20220611-x64 by Stephen Williams

**GTKWave LTS:** v3.3.126
