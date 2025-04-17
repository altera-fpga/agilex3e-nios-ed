# Nios V Example Designs Repository

This repository contains the Nios V Example designs based on Agilex™ 3 FPGA C-Series 135 (M16A) A3CW135BM16AE6S

Development Kit product page- https://www.intel.com/content/www/us/en/content-details/833122/agilex-3-fpgas-and-socs-product-brief.html 

The following table contains the list of Acronyms that the user may come across in the design details

| Acronym | Expansion |
| --- | ------ |
| DMA | Direct Memory Access |
| OCM | On-Chip Memory |
| PIO | Parallel I/O |
| RTOS | Real Time Operating System |
| GHRD | Golden Hardware Reference Design |

There are three variants of the NiosV core:
    
    a. Nios V/m core - Microcontroller- Balanced (For interrupt driven baremetal and RTOS code)
    
    b. Nios V/g core - General-Purpose Processor- High Performance (For interrupt driven baremetal and RTOS code)

    c. Nios V/c core - Compact Microcontroller- Smallest (For non-interrupt driven baremetal code)


The following table contains the list of the designs on Agilex™ 3 FPGA C-Series 135 (M16A) A3CW135BM16AE6S

| # | Nios V core | Design name | Description |
| - | --- | ------ | ----------- |
| 1 | Nios V/m | Baseline Golden Hardware Reference Design (GHRD) | This design demonstrates the baseline Golden Hardware Reference Design (GHRD) for a Nios V/m processor with basic bare minimum peripherals required for any application execution <br>[Design details](niosv_m/baseline_ghrd/docs/Nios_Vm_Processor_Baseline_GHRD_Design_on_Agilex_3_FPGA.md)


Refer to the documents in the following link for More information on the Nios V Processor core - [https://www.intel.com/content/www/us/en/support/programmable/support-resources/support-centers/nios-v-support.html ](https://www.intel.com/content/www/us/en/support/programmable/support-resources/support-centers/nios-v-support.html#introtext_1506028531_1693475107)
