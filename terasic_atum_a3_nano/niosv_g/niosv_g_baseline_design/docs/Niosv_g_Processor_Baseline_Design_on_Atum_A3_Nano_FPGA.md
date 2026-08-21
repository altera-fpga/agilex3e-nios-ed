# Nios® V/g Baseline Design

This design demonstrates the Baseline Design for a Nios® V/g processor with basic bare minimum peripherals required for any application execution

## Description

This example design includes a Nios® V/g processor connected to the On Chip RAM-II, JTAG UART IP, Parallel- IO and System ID peripheral core. 

The objective of the design is to accomplish data transfer between the processor and on chip memory and toggling the on board LEDs with and without using the Push Button. 


![image](https://github.com/altera-fpga/agilex3-ed-niosv/blob/rel/26.1.1/terasic_atum_a3_nano/niosv_g/niosv_g_baseline_design/img/baseline_design_block_design.png)

## Project Details

* **Title**: Nios® V/g Baseline Design
* **Source**: Github
* **Design Support**: SCTH
* **Family**: Agilex 3
* **Quartus Version**: 26.1.1
* **Development Kit**: Atum Nios V Starter Kit
* **Device Part**: A3CZ135BB18AE7S
* **Design Package**: atum_niosv_g_Baseline_Design.zip
* **Category**: Nios V
* **URL**: https://github.com/altera-fpga/agilex3-ed-niosv/blob/rel/26.1.1/niosv_g/niosv_g_baseline_design
* **downloadURL**: https://github.com/altera-fpga/agilex3-ed-niosv/releases/download/26.1.1/atum_niosv_g_baseline_design.zip

## Documentation

* **Title**: Design Document
* **URL**: https://github.com/altera-fpga/agilex3-ed-niosv/blob/rel/26.1.1/niosv_g/niosv_g_baseline_design/docs/Niosvg_processor_Baseline_Design_on_Atum_A3_Nano_FPGA.md

# Getting Started

Vendor: Altera

Devkit Product Page: https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=44&No=1373#contents

1. Directory structure
2. Building the design from scratch

    a.	Required directory structure

    b.	Use of build_sof.py to compile the design

    c.	Steps to create the bsp and build software sources
    
3. Running simulation

### 1. Directory Structure:

The directory structure is explained below:

- hw- necessary hardware files (.qpf, .qsf, .sv, .v, .ip) of the design

- sw- This folder contains software application files

- scripts- This folder consists of scripts to build the design


### 2. Building the design from scratch

The steps to build the project from scratch are mentioned below:

a. Required directory structure
- The top-level project folder should have directory structure as mentioned in Section 1 (Directory Structure).

b. Using build_sof.py to compile the design
- Invoke the quartus_py shell in the terminal

- Run the following command in the terminal from top level project directory:
```
quartus_py ./scripts/build_sof.py
```
- The quartus tool will compile the design and generate the output files

c. Creating the bsp, build software sources and download elf
- To create software app, run the following commands in the terminal:

- Clean the app build project before regenerating elf

- application with pushbutton logic

```     
niosv-bsp -c --quartus-project=hw/top.qpf --system=hw/src/vds/qsys_top/qsys_top.vds --type=hal sw/bsp_with_pb/settings.bsp
niosv-app --bsp-dir=sw/bsp_with_pb --app-dir=sw/app_with_pb --srcs=sw/app_with_pb/main.c
cmake -S ./sw/app_with_pb -B sw/app_with_pb/build
make -C sw/app_with_pb/build
```

- application without pushbutton logic

```
niosv-bsp -c --quartus-project=hw/top.qpf --system=hw/src/vds/qsys_top/qsys_top.vds --type=hal sw/bsp_without_pb/settings.bsp
niosv-app --bsp-dir=sw/bsp_without_pb --app-dir=sw/app_without_pb --srcs=sw/app_without_pb/main.c
cmake -S ./sw/app_without_pb -B sw/app_without_pb/build
make -C sw/app_without_pb/build
elf2hex sw/app_without_pb/build/app_without_pb.elf -b 0x0 -w 32 -e 0x3ffff hw/onchip_mem.hex -r4
```

### 3. Running simulation

Simulation is enabled for this design where the memory is initialized with the application hex and the application is the one without the pushbutton. Use the following commands to run the simulation:

- Generate Testbench from Visual Design Studio. Tools -> Generate System 
```	
cp ./hw/onchip_mem.hex ./hw/gen/vds/qsys_top_tb/sim/mentor 
cd hw/gen/vds/qsys_top_tb/sim/mentor
vsim &
source msim_setup.tcl
ld_debug
run -all
```
