# Nios® V/g 1000M HTTP Server Example Design 

This design demonstrates a simple HTML HTTP server on a Nios® V/g processor
using the Triple Speed Ethernet IP for the Atum A3 Nano FPGA board.

## Description

The System Example Design demonstrates a 1000M full-duplex Ethernet
application. The Nios V/g acts as the core. The Triple Speed Ethernet (TSE) IP
is configured in RGMII mode and connects to the onboard DP83867IR TI PHY via
RGMII interface.

The design has 2 MSGDMA IPs configured in Memory Mapped to Stream (MM2S) mode for Transmission and Stream to Memory Mapped (S2MM) mode for Reception.

To test the application, connect the RGMII Interface of the Atum A3 Nano FPGA board to the Link Partner using RJ-45 cable.

Default network settings:

```text
FPGA IP address: 10.0.0.2
Host IP address: 10.0.0.1
HTTP port: 80
UDP loopback port: 5002
```

Ensure that the IP addresses are modified accordingly in the application code under the following location - sw/app_freertos/main.c

Once the application binaries are downloaded, the board starts pinging the link
partner automatically and serves a simple HTML page at `http://10.0.0.2/`.

This design is created on the Quartus Visual Designer Studio. Fore more Information please visit here Visual Designer Studio[https://www.altera.com/products/development-tools/visual-designer-studio].


![image](https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/26.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping/img/web_server_block_diagram.png)


## TSE and MSGDMA driver overlay

For 26.1, when the user builds the Niosv BSP, the driver code for TSE and MSGDMA are not compatible with Agilex 3.

Use the checked-in software build script so the generated BSP receives the
validated AlteraTSE driver overlay and FreeRTOS TCP/IP config:

```sh
./scripts/build_sw_http_server.sh
```

Manual flow, if needed:

1. Create the BSP manually by running the command in section 3.c below

2. Remove the following folder: sw/bsp_freertos/FreeRTOS_TCP_IP/source/portable/NetworkInterface/AlteraTSE/

3. Replace it with the AlteraTSE folder shared with the package .zip or uploaded under sources/sw in github repository.

4. Copy `sw/FreeRTOSIPConfig.h` to `sw/bsp_freertos/FreeRTOS_TCP_IP/source/include/FreeRTOSIPConfig.h`.

5. Run the app creation, cmake and make commands from section 3c below. Do not re-generate BSP as it will overwrite the replaced driver files.


## Link Partner settings

1. Set the following setting on the interface of the link partner

    Speed- 1000 Mbps

    Duplex- Full

    Auto-Negotiation- On

command: ethtool -s <interface_name> speed 1000 duplex full autoneg on


## Expected Output

The snapshot below captures the output on the board when the elf file is downloaded (See section 3.d below for the steps to download).

Board IP address: 10.0.0.2

Link partner (linux host) IP address: 10.0.0.1

Speed: 1000Mbps

Expected validation markers:

```text
PHY resolved: speed=1000M duplex=full
TSE MAC speed config: eth_mode=1 ena_10=0
4 packets transmitted, 4 received, 0% packet loss
HTTP_FETCH_STATUS attempt=1 HTTP/1.1 200 OK
HTTP_FETCH_RESULT PASS
frames_check_sequence_errors = 0x0
alignment_errors = 0x0
```

![image](https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/26.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping/img/expected_output.png)

## Project Details

- **Title**: Nios® V/g Ping System Example Design
- **Source**: Github
- **Design Support**: CTH
- **Family**: Agilex 3
- **Quartus Version**: 26.1
- **Development Kit**: default
- **Device Part**: A3CZ135BB18AE7S
- **Design Package**: atum_a3_nano_niosv_g_webserver_ping.zip
- **Category**: Networking
- **URL**: https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/26.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping
- **download URL**: https://github.com/altera-fpga/agilex3c-nios-ed/releases/download/26.1/atum_a3_nano_niosv_g_webserver_ping.zip

## Documentation

- **Title**: Design Document 
**URL**: https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/26.1/terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping/docs/Nios_Vg_Processor_Webserver_Ping_Design_on_Atum_A3_Nano_FPGA.md


# Getting Started

Vendor: Terasic
 
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
export LM_LICENSE_FILE=/home/dev/License.dat
cp custom_logic/core_sdram_axi/core_sdram_axi4_hw.tcl ./hw
cp custom_logic/core_sdram_axi/sdram_axi.v ./hw
cp custom_logic/core_sdram_axi/sdram_axi_core.v ./hw
cp custom_logic/core_sdram_axi/sdram_axi_pmem.v ./hw
quartus_py ./scripts/build_sof.py
```
- The quartus tool will compile the design and generate the output files

The VDS system file is tracked, while the VDS child IP files under
`hw/src/vds/qsys_top/ip/` are generated build outputs. `build_sof.py` runs
`scripts/generate_vds_ip.sh` automatically before `quartus_ipgenerate`.

For a deterministic hardware build from a clean workspace, this command sequence is validated:
```
export LM_LICENSE_FILE=/home/dev/License.dat
cp custom_logic/core_sdram_axi/core_sdram_axi4_hw.tcl ./hw
cp custom_logic/core_sdram_axi/sdram_axi.v ./hw
cp custom_logic/core_sdram_axi/sdram_axi_core.v ./hw
cp custom_logic/core_sdram_axi/sdram_axi_pmem.v ./hw
cd hw
quartus_sh -t ../scripts/top.tcl
../scripts/generate_vds_ip.sh
quartus_ipgenerate top.qpf
quartus_sh --flow compile top
```

c. Creating the bsp, build software sources and download elf
- To create software app, run the following commands in the terminal:

- Clean the app build project before regenerating elf

```     
./scripts/build_sw_http_server.sh
```
Note:The software can be compiled using the Ashling Visual Studio Code Extension for Altera FPGAs

For information on the build process, please refer to the following document- [Ashling VSCode Extension](https://www.intel.com/content/www/us/en/docs/programmable/730783/current/ashling-visual-studio-code-extension.html)

d. Hardware Validation

The TSE IP is time-limited in FPGA IP Evaluation Mode, so keep
`quartus_pgm` open during runtime validation. From the parent design directory:

```sh
./run_tse_eval_http_server.sh
```

The full clean build plus hardware validation is:

```sh
./run_tse_eval_http_full.sh
```

The script programs the time-limited SOF, holds the eval prompt open, sets the
JTAG clock to 6 MHz, forces 1000M ISSP mode, downloads the ELF, captures JTAG
UART, pings the FPGA, fetches the HTML page, and closes the eval prompt.
