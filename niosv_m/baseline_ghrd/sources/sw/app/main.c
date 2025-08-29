// #include <stdio.h>
// #include <stdint.h>
// #include <system.h>
// //#include "altera_avalon_sysid_qsys_regs.h"




// int main()

// {
//   //      int sys_id;
//         printf ("Hello World \n");
// //	printf ("Print the value of System ID \n");
// //        sys_id = IORD_ALTERA_AVALON_SYSID_QSYS_ID(SYSID_QSYS_0_BASE);
// //        printf ("System ID from Peripheral core is 0x%X \n",sys_id);



// return 0;
// }
#include <stdio.h>
#include <system.h>
#include <io.h>
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_sysid_qsys_regs.h"
#include <unistd.h>

#define OCM_BASE INTEL_ONCHIP_MEMORY_0_BASE
// Using usleep as the delay funciton
    int usleep(useconds_t usec);

    void mem_test();
    int pio_test();

    void mem_test ()
	{

        printf("Starting Memory test \n");
		
        int i;
        int p, p_updated;

        for (i =0 ; i < 32 ; i=i+4)
        {
            p=IORD_32DIRECT(OCM_BASE,i);
            printf("value at memory location 0x%x with offset %d is 0x%x\n",OCM_BASE,i, p);

            IOWR_32DIRECT(OCM_BASE,i,0xa5a5a5a5);
            p_updated = IORD_32DIRECT(OCM_BASE,i);
            printf("After write: value at memory location 0x%x with offset %d is 0x%x\n",OCM_BASE,i, p_updated);

            if(p_updated == 0xa5a5a5a5)
            {
                printf("Memory write test PASSED\n");
            }
            else
            {
                printf("Memory write test FAILED at location 0x%X\n",(OCM_BASE+i));
            }
        }

        	printf("Memory Test Complete \n");


	}


int pio_test()
{
    int count = 0;
    int i;
    int iter = 0;
    int pio_err = 0;
    printf("Application to toggle the PIOs- [4:0] \n");

    // increase the below value while testing the leds on board
    while (iter < 10000000)
    {
        if (count == 64)
        {
            count = 0;
            IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, 0xf);
        }
        // Generate a test pattern to write to PIO
        i = count & 0xf;
        IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, count & 0xf);
        // IORD_ALTERA_AVALON_PIO_DATA(PIO_1_BASE);
        usleep(100);
        
        // Read back value from PIO
        printf("DATA READBACK FROM PIO_0_BASE is 0x%x \n", IORD_ALTERA_AVALON_PIO_DATA(PIO_0_BASE));
        printf("DATA READBACK FROM PIO_1_BASE is 0x%x \n", IORD_ALTERA_AVALON_PIO_DATA(PIO_1_BASE));

        // Verify the read-back value matches expected pattern
        if (i != IORD_ALTERA_AVALON_PIO_DATA(PIO_0_BASE))
        {
            printf("Data MISMATCH - TEST FAILED \n");
            pio_err++;
        }
        else
        {
            printf("DATA MATCHED - TEST PASSED \n");
        }
        count++;
        iter++;
    }
    return pio_err;
}



int main () 
{
    int pio_fail_flag;
    int sys_id;


		
    printf("Hello World from NiosV Baseline GHRD \n");
		
    mem_test();

    pio_fail_flag = pio_test();

    if ((pio_fail_flag != 0)  )
    {
        printf ("NIOSV-PIO Test failed with PIO_ERR = %d\n",pio_fail_flag);
    }
    else
    {
			
        printf ("NIOSV-PIO Test PASSED \n");
    }

    printf ("Print the value of System ID \n");
    sys_id = IORD_ALTERA_AVALON_SYSID_QSYS_ID(SYSID_QSYS_0_BASE);
    printf ("System ID from Peripheral core is 0x%X \n",sys_id);

    return 0;  
}