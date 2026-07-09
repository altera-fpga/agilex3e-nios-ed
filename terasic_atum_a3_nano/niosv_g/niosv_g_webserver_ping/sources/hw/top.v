// (C) 2001-2026 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2024 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2023 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// Copyright (C) 2001-2022 Intel Corporation 
//
// This code and the related documents are Intel copyrighted materials, and
// your use of them is governed by the express license under which they were
// provided to you ("License"). Unless the License provides otherwise, you may
// not use, modify, copy, publish, distribute, disclose or transmit this
// code or the related documents without Intel's prior written permission
//
// This code and the related documents are provided as is, with no express
// or implied warranties, other than those that are expressly stated in the
// License.
//
// Warning for Reset Release IP: 
// =============================
// Do not instantiate this IP multiple time. Move this IP to your 
// top level if you are integrating this reference design into your design. 



module top (
   //Clock and Reset
   input wire         CLK_50M,     
//   //MDIO
   output wire        MDC,              // TI PHY management data refclk 
	inout wire         MDIO,             // TI PHY management data
	input [3:0]			 rgmii_in,
	output [3:0]		 rgmii_out,
	output wire			 rgmii_txclk,
	input wire 			 rgmii_rxclk,
	output wire			 rgmii_txctl,
	input wire 			 rgmii_rxctl,
	output wire			 phy_resetn,
//SDRAM
	output             DRAM_CLK,
   output             DRAM_CKE,
   output   [12: 0]   DRAM_ADDR,
   output   [ 1: 0]   DRAM_BA,
   inout    [31: 0]   DRAM_DQ,
   output             DRAM_CS_n,
   output             DRAM_WE_n,
   output             DRAM_CAS_n,
   output             DRAM_RAS_n,
   output   [ 3: 0]   DRAM_DQM
);

// -------------------------------------------------------------------------
// Wires declaration 
// -------------------------------------------------------------------------

wire        init_done_n;
wire        global_reset;
wire        global_reset_n;
wire			sys_pll_locked;
wire 			processing_clk;
wire			sdram_clk;

// MDIO
wire 			mdio_in;
wire 			mdio_oen;
wire 			mdio_out;


wire 			phy_reset;
wire 			reset_n;


wire        set_10;       
wire        set_1000;     
wire        eth_mode;     
wire        ena_10;       
reg  [15:0] rgmii_rxclk_count;

wire    [31: 0]   dram_data_out;
wire    [31: 0]   dram_data_in;
wire              dram_data_oe;


assign DRAM_DQ = dram_data_oe ? dram_data_out : 32'hZZZZ;
assign dram_data_in = DRAM_DQ;

// -------------------------------------------------------------------------
// Reset Release IP
// -------------------------------------------------------------------------
// Warning: Do not instantiate this IP multiple time. Move this IP to your 
// top level if you are integrating this reference design into your design. 
reset_release reset_release_0 (
    .ninit_done (init_done_n)  //  output,  width = 1, ninit_done.ninit_done
);


//// -------------------------------------------------------------------------
//// Reset assignments- comment 2
//// -------------------------------------------------------------------------
assign global_reset_n = ~init_done_n;

buf b0 (mdio_in,MDIO);
bufif1 b1 (MDIO,mdio_out,~mdio_oen);


//adding iopll for reset

  sys_pll sys_pll_inst(
  	.rst      (init_done_n), 
  	.refclk   (CLK_50M),
  	.locked   (sys_pll_locked),
  	.outclk_0 (processing_clk),
	.outclk_1 (DRAM_CLK),
	.outclk_2 (sdram_clk)
  	);

assign global_reset = ~sys_pll_locked;


issp issp_rst (
.source ({phy_resetn,set_1000}),
.probe ({rgmii_rxclk_count, eth_mode, ena_10})
);

always @(posedge rgmii_rxclk or posedge global_reset) begin
	if (global_reset) begin
		rgmii_rxclk_count <= 16'd0;
	end else begin
		rgmii_rxclk_count <= rgmii_rxclk_count + 16'd1;
	end
end


	

// -------------------------------------------------------------------------	 
// Triple-speed Ethernet Platform Designer system
// ------------------------------------------------------------------------- 
qsys_top qsys_top_0 ( 	  
	.triple_speed_ethernet_0_mac_misc_connection_ff_tx_crc_fwd	  (1'b0),
	.triple_speed_ethernet_0_mac_misc_connection_ff_tx_septy	     (), 
	.triple_speed_ethernet_0_mac_misc_connection_tx_ff_uflow	     (), 
	.triple_speed_ethernet_0_mac_misc_connection_ff_tx_a_full	  (),
	.triple_speed_ethernet_0_mac_misc_connection_ff_tx_a_empty    (),
	.triple_speed_ethernet_0_mac_misc_connection_rx_err_stat	     (), 
	.triple_speed_ethernet_0_mac_misc_connection_rx_frm_type	     (), 
	.triple_speed_ethernet_0_mac_misc_connection_ff_rx_dsav		  (),  
	.triple_speed_ethernet_0_mac_misc_connection_ff_rx_a_full	  (),
	.triple_speed_ethernet_0_mac_misc_connection_ff_rx_a_empty    (),
	.sys_tse_mac_mdio_connection_mdc                              (MDC),                              
   .sys_tse_mac_mdio_connection_mdio_in                          (mdio_in),                          
   .sys_tse_mac_mdio_connection_mdio_out                         (mdio_out),                         
   .sys_tse_mac_mdio_connection_mdio_oen                         (mdio_oen),                         
	.sys_tse_mac_rgmii_connection_rgmii_in								  (rgmii_in),
	.sys_tse_mac_rgmii_connection_rgmii_out							  (rgmii_out),
	.sys_tse_mac_rgmii_connection_rgmii_tx_clk						  (rgmii_txclk),
	.sys_tse_mac_rgmii_connection_rgmii_rx_clk						  (rgmii_rxclk),
	.sys_tse_mac_rgmii_connection_rx_control							  (rgmii_rxctl),
	.sys_tse_mac_rgmii_connection_tx_control							  (rgmii_txctl),
	.sys_tse_pcs_mac_tx_clock_connection_clk							  (rgmii_rxclk),
	.sys_tse_pcs_mac_rx_clock_connection_clk							  (rgmii_rxclk),
	.sys_tse_mac_status_connection_set_10                      	  (set_10),                     
   .sys_tse_mac_status_connection_set_1000                    	  (set_1000),                   
   .sys_tse_mac_status_connection_eth_mode                    	  (eth_mode),                   
   .sys_tse_mac_status_connection_ena_10                      	  (ena_10),
	.core_sdram_axi4_0_sdram_cke                               	  (DRAM_CKE),                               
   .core_sdram_axi4_0_sdram_cs_n                              	  (DRAM_CS_n),                              
   .core_sdram_axi4_0_sdram_ras_n                             	  (DRAM_RAS_n),                             
   .core_sdram_axi4_0_sdram_cas_n                             	  (DRAM_CAS_n),                             
   .core_sdram_axi4_0_sdram_we_n                              	  (DRAM_WE_n),                              
   .core_sdram_axi4_0_sdram_dqm                               	  (DRAM_DQM),                               
   .core_sdram_axi4_0_sdram_addr                              	  (DRAM_ADDR),                              
   .core_sdram_axi4_0_sdram_ba                                	  (DRAM_BA),                                
   .core_sdram_axi4_0_sdram_data_out                          	  (dram_data_out),                          
   .core_sdram_axi4_0_sdram_data_oe                           	  (dram_data_oe),                           
   .core_sdram_axi4_0_sdram_data_in									     (dram_data_in),
	.proc_clk_clk                                                 (processing_clk),                                              
   .proc_rst_reset 														     (global_reset),
	.sdram_clk_clk															     (sdram_clk),
	.sdram_rst_reset														     (global_reset) 	
);


endmodule 
