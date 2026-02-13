# Nios® V/g Ping Design 

 This design demonstrates the Ping application on a Nios® V/g processor using the Triple Speed Ethernet IP for the Atum 3 Terasic Development Kit.

## Description

The example design demonstrates ping application. The Nios V/g acts as the core. The Triple Speed Ethernet (TSE) IP is configured in RGMII mode and connectes to the onboard DP83867IR TI PHY via RGMII interface. 

The design has 2 MSGDMA IPs configured in Memory Mapped to Stream (MM2S) mode for Transmission and Stream to Memory Mapped (S2MM) mode for Reception.

To test the application, connect the RGMII Interface of the Atum 3 Development Kit to the Link Partner using RJ-45 cable.

Ensure that the IP addresses are modified accordingly in the application code under the following location - sw/app_freertos/main.c

Once the application binaries are downloaded (See section 3.d below for the steps), the board starts pinging the link partner automatically.

Observe the Ping Request and Response prints on the terminal.


![image](https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/25.3.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping/img/web_server_block_diagram.png)


## Manual update of the TSE and MSGDMA driver code

For 25.3.1, when the user builds the Niosv BSP, the driver code for TSE and MSGDMA are not compatible with Agilex 3.

To ensure the correct files are picked, please do the following steps:

1. Create the BSP manually by running the command in section 3.c below

2. Remove the following folder: sw/bsp_freertos/FreeRTOS_TCP_IP/source/portable/NetworkInterface/AlteraTSE/

3. Replace it with the AlteraTSE folder shared with the package .zip or uploaded under sources/sw in github repository.

4. Run the app creation , cmake and make commands from section 3c below. Do not re-generate BSP as it will overwrite the replaced driver files.


## Link Partner settings

1. Set the following setting on the interface of the link partner

    Speed- 100 Mbps

    Duplex- Full

    Auto-Negotiation- Off

command: ethtool -s <interface_name> speed 100 duplex full autoneg off


## Expected Output

The snapshot below captures the output on the board when the elf file is downloaded (See section 3.d below for the steps to download).

Board IP address: 10.0.0.2

Link partner (linux host) IP address: 10.0.0.1

Speed: 100Mbps

![image](https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/25.3.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping/img/expected_output.png)

## Project Details

- **Title**: Nios® V/g Ping Design
- **Source**: Github
- **Design Support**: CTH
- **Family**: Agilex 3
- **Quartus Version**: 25.3.1
- **Development Kit**: default
- **Device Part**: A3CZ135BB18AE7S
- **Design Package**: atum_a3_nano_niosv_g_webserver_ping.zip
- **Category**: Networking
- **URL**: https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/25.3.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping
- **download URL**: https://github.com/altera-fpga/agilex3c-nios-ed/releases/download/25.3.1/atum_a3_nano_niosv_g_webserver_ping.zip

## Documentation

- **Title**: Design Document 
**URL**: https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/25.3.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping/docs/Nios_Vg_Processor_Webserver_Ping_Design_on_Atum_A3_Nano_FPGA.md


# Getting Started

Vendor: Altera
 
1. Directory structure
2. Using existing files (sof and elf) to run on hardware
3. Building the design from scratch

    a.	Required directory structure

    b.	Use of build_sof.py to compile the design

    c.	Steps to create the bsp and build software sources

    d.  Hardware Validation 


### 1. Directory Structure:

The directory structure is explained below:

- hw- necessary hardware files (.qpf, .qsf, .sv, .v, .ip) of the design

- sw- This folder contains software application files

- scripts- This folder consists of scripts to build the design


### 2. Using existing files to run the design on hardware

- The sof and elf files required to run the design can be found in "ready_to_test" folder 

- Refer the Hardware validation section (3.d) for the steps  


### 3. Building the design from scratch

The steps to build the project from scratch are mentioned below:

a. Required directory structure
- The top-level project folder should have directory structure as mentioned in Section 1 (Directory Structure).

b. Using build_sof.py to compile the design
- Invoke the quartus_py shell in the terminal

- Run the following command in the terminal from top level project directory:
```
cp custom_logic/emif_axi_adaptor_hw.tcl ./hw
cp custom_logic/emif_axi_handler.sv ./hw 
quartus_py ./scripts/build_sof.py
```
- The quartus tool will compile the design and generate the output files

c. Creating the bsp, build software sources and download elf
- To create software app, run the following commands in the terminal:

- Clean the app build project before regenerating elf

```     
niosv-bsp -c --quartus-project=hw/top.qpf --qsys=hw/qsys_top.qsys --type=freertos --cmd="enable_sw_package altera_freertos_tcpip" --script=sw/bsp_settings.tcl --no-default sw/bsp_freertos/settings.bsp
niosv-app --bsp-dir=sw/bsp_freertos --app-dir=sw/app_freertos --srcs=sw/app_freertos/main.c
cmake -S ./sw/app_freertos -B sw/app_freertos/build
make -C sw/app_freertos/build
```
Note:The software can be compiled using the Ashling Visual Studio Code Extension for Altera FPGAs

For information on the build process, please refer to the following document- [Ashling VSCode Extension](https://www.intel.com/content/www/us/en/docs/programmable/730783/current/ashling-visual-studio-code-extension.html)

d. Hardware Validation
- Program the generated sof and then download the elf file on the board
```        
quartus_pgm --cable=1 -m jtag -o 'p;ready_to_test/top.sof'
``` 
- Reduce the JTAG clock frequency to 6MHz before programming the application .elf file on the board.
```
jtagconfig --setparam 1 JtagClock 6M
```
- Toggle the In-System-Sources and Probe (ISSP) IP to initialize PHY and set it to 1G.
```
quartus_stp -t ready_to_test/toggle_issp.tcl
```
- Download the elf file on the board 
```    
niosv-download -g -r ready_to_test/app_freertos.elf -c 1
``` 
- Verify the output on the terminal by using the following command in the terminal:
``` 
juart-terminal -d 1 -c 1 -i 0 
```