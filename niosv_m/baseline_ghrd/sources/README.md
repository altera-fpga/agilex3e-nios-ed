# Agilex 3 FPGA - Nios® V/m Baseline Golden Hardware Reference Design (GHRD)

This design demonstrates the Baseline Golden Hardware Reference Design (GHRD) for a Nios® V/m processor with basic bare minimum peripherals required for any application execution

## Description

This example design includes a Nios® V/m processor connected to the On Chip RAM-II, JTAG UART IP, Parallel- IO and System ID peripheral core. 

The objective of the design is to accomplish data transfer between the processor and on chip memory. 

###### Note: The sof (binary) generation is not supported for Agilex 3 devices on Quartus 25.1 version. Hence, you will observe "sof not generated" critical warning while compiling this design.

![image](https://github.com/altera-fpga/agilex3e-nios-ed/blob/rel/25.1.0/niosv_m/baseline_ghrd/img/baseline_ghrd_block_design.png)

## Project Details

* **Title**: Agilex 3 FPGA - Nios® V/m Baseline Golden Hardware Reference Design (GHRD)
* **Source**: Github
* **Design Support**: SCT
* **Family**: Agilex 3
* **Quartus Version**: 25.1.0
* **Development Kit**: Agilex™ 3 FPGA C-Series 135 (M16A) A3CW135BM16AE6S
* **Device Part**: A3CW135BM16AE6S
* **Design Package**: agilex3_niosv_m_baseline_ghrd.zip
* **Category**: GHRD
* **URL**: https://github.com/altera-fpga/agilex3e-nios-ed/tree/rel/25.1.0/niosv_m/baseline_ghrd
* **downloadURL**: https://github.com/altera-fpga/agilex3e-nios-ed/releases/download/25.1.0-v1.0/agilex3_niosv_m_baseline_ghrd.zip

## Documentation

* **Title**: Design Document
* **URL**: https://github.com/altera-fpga/agilex3e-nios-ed/blob/rel/25.1.0/niosv_m/baseline_ghrd/docs/Nios_Vm_Processor_Baseline_GHRD_Design_on_Agilex_3_FPGA.md

# Getting Started

Vendor: Altera

Devkit Product Page: https://www.intel.com/content/www/us/en/docs/programmable/817231/current/overview-of-the-fpgas-and-socs.html

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

```     
niosv-bsp -c --quartus-project=hw/top.qpf --qsys=hw/qsys_top.qsys --type=hal sw/bsp/settings.bsp
niosv-app --bsp-dir=sw/bsp --app-dir=sw/app --srcs=sw/app/main.c
niosv-shell
cmake -S ./sw/app -B sw/app/build -G "Unix Makefiles"
make -C sw/app/build
elf2hex sw/app/build/app.elf -b 0x0 -w 32 -e 0x9ffff sw/app/build/onchip_mem.hex -r4
```

### 3. Running simulation

Simulation is enabled for this design where the memory is initialized with the application hex. Use the following commands to run the simulation:

- Generate Testbench from Platform Designer. Generate -> Generate Testbench System 
```	
cp ./sw/app/build/onchip_mem.hex ./qsys_top_tb/qsys_top_tb/sim/mentor 
cd hw/qsys_top_tb/qsys_top_tb/sim/mentor/
vsim &
source msim_setup.tcl
ld_debug
run -all
```
