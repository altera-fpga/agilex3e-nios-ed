# Nios V Example Designs Repository

This repository contains the Nios V Example design based on Terasic Atum A3 Nano FPGA board

FPGA board product page- https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=44&No=1373#contents

The following table contains the list of Acronyms that the user may come across in the design details

| Acronym | Expansion |
| --- | ------ |
| MSGDMA | Modular Scatter-Gather Direct Memory Access |
| OCM | On-Chip Memory |
| PIO | Parallel I/O |
| RTOS | Real Time Operating System |

There are three variants of the NiosV core:
    
    a. Nios V/m core - Microcontroller- Balanced (For interrupt driven baremetal and RTOS code)
    
    b. Nios V/g core - General-Purpose Processor- High Performance (For interrupt driven baremetal and RTOS code)

    c. Nios V/c core - Compact Microcontroller- Smallest (For non-interrupt driven baremetal code)


The following table contains the list of the designs on Terasic Atum A3 Nano FPGA board

| # | Nios V core | Design name | Description |
| - | --- | ------ | ----------- |
| 1 | Nios V/g | Nios V/g Webserver Ping Design | This design demonstrates the Ping application using the Triple Speed Ethernet IP <br>[Design details](terasic_atum_a3_nano/niosv_g/niosv_g_webserver_ping/docs/Niosv_g_Processor_Webserver_Ping_Design_on_Atum_A3_Nano_FPGA.md)|
| 2 | Nios V/g | Nios V/g TinyML LiteRT | This design demonstrates the TinyML application using LiteRT for microcontrollers software with Nios® V/g processor<br>[Design details](terasic_atum_a3_nano/niosv_g/niosv_g_tinyml_liteRT/docs/Niosv_g_Processor_TinyML_Design_on_Terasic_Atum_A3_Nano_FPGA.md) |


Refer to the documents in the following link for More information on the Nios V Processor core - [https://www.intel.com/content/www/us/en/support/programmable/support-resources/support-centers/nios-v-support.html ](https://www.intel.com/content/www/us/en/support/programmable/support-resources/support-centers/nios-v-support.html#introtext_1506028531_1693475107)
