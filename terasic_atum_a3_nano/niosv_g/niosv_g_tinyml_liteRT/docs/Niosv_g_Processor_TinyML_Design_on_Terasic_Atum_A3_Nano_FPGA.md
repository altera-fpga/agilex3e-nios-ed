## Introduction

### Nios® V/g TinyML LiteRT System Example Design Overview

This design demonstrates the TinyML application using LiteRT for microcontrollers software with Nios® V/g processor in the Atum A3 Nano FPGA board.

### Prerequisites

 - Atum A3 Nano FPGA board. Refer to the board documentation for more information about the development kit.
 - Mini and Micro USB Cable. Included with the development kit.
 
### Release Contents  

#### Binaries
 - Prebuilt binaries are located [here](https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/26.1/terasic_atum_a3_nano/niosv_g/niosv_g_tinyml_liteRT/ready_to_test).
 - The sof and elf files required to run the design can be found in "ready_to_test" folder 
 - Program the sof and download the elf file on board

### Nios® V/g TinyML LiteRT Design Architecture
 This example design includes a Nios® V processor connected to the On Chip RAM-II, JTAG UART IP and System ID peripheral core. The objective of the design is to accomplish data transfer between the processor and soft IP peripherals.
 
 ![Block Diagram](https://github.com/altera-fpga/agilex3c-nios-ed/blob/rel/26.1/terasic_atum_a3_nano/niosv_g/niosv_g_tinyml_liteRT/img/block_diagram.png)

#### Nios® V/g Processor 
- Balanced (For interrupt driven baremetal and RTOS code)
- Nios® V/g processor is highly customizable and can be tailored to meet specific application requirements, providing flexibility and scalability in embedded system designs.

 
#### IP Cores
 The following IPs are used in this Platform Designer component of the design:
- Nios® V/g soft processor core

- On Chip RAM-II

- JTAG UART

- System ID

- Clock Bridge, Reset Controller


### Hardware Setup

  Refer to [Atum A3 Nano FPGA board](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=44&No=1373#contents) to setup the hardware connection.


### Address Map Details

#### Nios V Address Map
 |Address Offset	|Size (Bytes)	|Peripheral	| Description|
  |-|-|-|-|
  |0x0010_0000|524288|On-Chip RAM|To store application|
  |0x0000_0448|8|JTAG UART|Communication between a host PC and the Nios V processor system|
  |0x0000_00440|8|System ID|Hardware configuration system ID (0x00000000)|


### User Flow 

 There are two ways to test the design based on use case. 

   <h5> User Flow 1: Testing with Prebuild Binaries.</h5>
   
   <h5> User Flow 2: Testing Complete Flow.</h5>

 |User Flow|Description|Required for [User flow 1](#user-flow-1-testing-with-prebuild-binaries)|Required for [User flow 2](#user-flow-2-testing-complete-flow)|
 |-|-|-|-|
 |Environment Setup|[Tools Download and Installation](#tools-download)|Yes|Yes|
 |Compilation|Hardware compilation|No|Yes|
 ||Software compilation|No|Yes|    
 |Programing|Program Hardware Binary SOF|Yes|Yes|
 ||Program Software Image ELF|Yes|Yes|
 |Testing|Open JTAG UART Terminal|Yes|Yes|

### Environment Setup

#### Tools Download and Installation
1. Quartus Prime Pro

 - Download the Quartus® Prime Pro Edition software version 26.1 from the FPGA Software Download Center webpage of the Intel website. Follow the on-screen instructions to complete the installation process. Choose an installation directory that is relative to the Quartus® Prime Pro Edition software installation directory.
 - Set up the Quartus tools in the PATH, so they are accessible without full path.
```console
export QUARTUS_ROOTDIR=~/intelFPGA_pro/26.1/quartus/
export PATH=$QUARTUS_ROOTDIR/bin:$QUARTUS_ROOTDIR/linux64:$QUARTUS_ROOTDIR/../qsys/bin:$PATH
```

### Compilation 

#### Hardware Compilation 
 - Invoke the `quartus_py` shell in the terminal
 - Run the following command in the terminal from top level project directory:
 
```console
quartus_py ./scripts/build_sof.py
```

 - The quartus tool will compile the design and generate the output files

#### Software Compilation 
- To create software app, run the following commands in the terminal:
```console
niosv-bsp -c --quartus-project=hw/golden_top.qpf -s=hw/nios_system.qsys --type=hal --no-default --script=sw/bsp_script.tcl sw/tflite_bsp/settings.bsp
niosv-app --bsp-dir=sw/tflite_bsp --app-dir=sw/tflite_app --srcs-recursive=sw/tflite_app/image_classification,sw/tflite_app/signal,sw/tflite_app/tensorflow --incs=sw/tflite_app,sw/tflite_app/image_classification/model,sw/tflite_app/image_classification/image,sw/tflite_app/tensorflow,sw/tflite_app/third_party/flatbuffers/include,sw/tflite_app/third_party/gemmlowp,sw/tflite_app/third_party/kissfft,sw/tflite_app/third_party/ruy
cmake -S ./sw/tflite_app -B sw/tflite_app/build/Release -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
make -C sw/tflite_app/build/Release
```

### Programing 
Note: Reduce the JTAG clock frequency to 6MHz using the following command, before programming the sof file
```console
jtagconfig --setparam 1 JtagClock 6M
```

#### Program Hardware Binary SOF
- Program the generated sof and then download the elf file on the board
    
```console
quartus_pgm --cable=1 -m jtag -o 'p;ready_to_test/top.sof'
```

#### Program Software Image ELF
- Download the elf file on the board
```console
niosv-download -g ready_to_test/tflite_app.elf -c 1
```

### Testing

#### Open JTAG UART Terminal
- Verify the output on the terminal by using the following command in the terminal:
    
```console
juart-terminal -c 1 -i 0 
```
