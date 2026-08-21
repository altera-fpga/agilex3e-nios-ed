# Terasic Atum A3 Nano FPGA - TinyML LiteRT System Example Design Example on Nios® V/g Processor 

Nios® V/g Processor-based TinyML LiteRT System Example Design on the Terasic Atum A3 Nano FPGA.

## Description

This design demonstrates the TinyML application using LiteRT for microcontrollers software with Nios® V/g processor on the Atum A3 Nano FPGA board. 

![image](https://github.com/altera-fpga/agilex3-ed-niosv/blob/rel/26.1.1/terasic_atum_a3_nano/niosv_g/niosv_g_tinyml_liteRT/img/block_diagram.png)

## Project Details

- **Title**: Nios V/g TinyML LiteRT System Example Design
- **Source**: Github
- **Design Support**: CTH
- **Family**: Agilex 3
- **Quartus Version**: 26.1.1
- **Development Kit**: Atum Nios V Starter Kit
- **Device Part**: A3CZ135BB18AE7S
- **Design Package**: atum_a3_nano_niosv_g_tinyml_liteRT.zip
- **Category**: AI
- **URL**: https://github.com/altera-fpga/agilex3-ed-niosv/blob/rel/26.1.1/terasic_atum_a3_nano/niosv_g/niosv_g_tinyml_liteRT
- **downloadURL**:https://github.com/altera-fpga/agilex3-ed-niosv/releases/download/26.1.1/atum_a3_nano_niosv_g_tinyml_liteRT.zip

## Documentation

- **Title**: Design Document 
**URL**:   https://github.com/altera-fpga/agilex3-ed-niosv/blob/rel/26.1.1/terasic_atum_a3_nano/niosv_g/niosv_g_tinyml_liteRT/docs/Niosv_g_Processor_TinyML_Design_on_Terasic_Atum_A3_Nano_FPGA.md

# Getting Started

Vendor: Terasic


1. Directory structure
2. Using existing files (sof and elf) to run on hardware
3. Building the design from scratch
    
    a. Required directory structure

    b. Use of build_sof.py to compile the design
    
    c. Steps to create the bsp and build software sources

    d.  Hardware Validation 
 
### 1. Directory Structure:
 
The directory structure of this top-level project folder is explained below:

- hw - necessary hardware files (.qpf, .qsf, .sv, .v, .ip) of the design

- sw - This folder contains software application files

- scripts - This folder consists of scripts to build the design

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
- To create software app, run the following commands in the terminal

- Clean the app build project before regenerating elf
```
niosv-bsp -c --quartus-project=hw/golden_top.qpf -s=hw/nios_system.qsys --type=hal --no-default --script=sw/bsp_script.tcl sw/tflite_bsp/settings.bsp
niosv-app --bsp-dir=sw/tflite_bsp --app-dir=sw/tflite_app --srcs-recursive=sw/tflite_app/image_classification,sw/tflite_app/signal,sw/tflite_app/tensorflow --incs=sw/tflite_app,sw/tflite_app/image_classification/model,sw/tflite_app/image_classification/image,sw/tflite_app/tensorflow,sw/tflite_app/third_party/flatbuffers/include,sw/tflite_app/third_party/gemmlowp,sw/tflite_app/third_party/kissfft,sw/tflite_app/third_party/ruy
cmake -S ./sw/tflite_app -B sw/tflite_app/build/Release -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
make -C sw/tflite_app/build/Release
```

d. Hardware Validation
- Program the generated sof and then download the elf file on the board
```  
quartus_pgm --cable=1 -m jtag -o 'p;ready_to_test/golden_top.sof'
```
- Reduce the JTAG clock frequency to 6MHz before programming the application .elf file on the board.
``` 
jtagconfig --setparam 1 JtagClock 6M
```
- Download the elf file on the board 
```
niosv-download -g ready_to_test/tflite_app.elf -c 1
```
- Verify the output on the terminal by using the following command in the terminal:
``` 
juart-terminal -d 1 -c 1 -i 0 
```
