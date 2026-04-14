// ============================================================================
// Copyright (c) 2025 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development
//   Kits made by Terasic.  Other use of this code, including the selling
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use
//   or functionality of this code.
//
// ============================================================================
//
//  Terasic Technologies Inc
//  No.80, Fenggong Rd., Hukou Township, Hsinchu County 303035. Taiwan
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//Date:  Mon Aug 18 13:47:53 2025
// ============================================================================

module golden_top(

      ///////// CLOCK /////////
//      input              CLOCK0_50,
      input              CLOCK1_50,

      ///////// KEY /////////
//      input    [ 3: 0]   KEY, //BUTTON is Low-Active

      ///////// SW /////////
//      input    [ 9: 0]   SW,

      ///////// LED /////////
//      output   [ 9: 0]   LEDR, //LED is Low-Active

      ///////// Seg7 /////////
//      output   [ 6: 0]   HEX0,
//      output   [ 6: 0]   HEX1,
//      output   [ 6: 0]   HEX2,
//      output   [ 6: 0]   HEX3,
//      output   [ 6: 0]   HEX4,
//      output   [ 6: 0]   HEX5,

      ///////// SDRAM /////////
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

      ///////// HDMI /////////
//      output             HDMI_TX_CLK,
//      output             HDMI_TX_HS,
//      output             HDMI_TX_VS,
//      output   [23: 0]   HDMI_TX_D,
//      output             HDMI_TX_DE,
//      input              HDMI_TX_INT,
//      inout              HDMI_LRCLK,
//      inout              HDMI_MCLK,
//      inout              HDMI_SCLK,
//      inout              HDMI_I2S0,

      ///////// UART /////////
//      output             UART_TX,
//      input              UART_RX,

      ///////// I2C for HDMI and ADC /////////
//      inout              I2C_SCL,
//      inout              I2C_SDA,

      ///////// GPIO /////////
//      inout    [35: 0]   GPIO_D

);


//=======================================================
//  REG/WIRE declarations
//=======================================================

wire    [ 9: 0]   led;

wire    [31: 0]   dram_data_out;
wire    [31: 0]   dram_data_in;
wire              dram_data_oe;

//=======================================================
//  Structural coding
//=======================================================

assign DRAM_DQ = dram_data_oe ? dram_data_out : 32'hZZZZ;
assign dram_data_in = DRAM_DQ;
//assign LEDR = ~led;

nios_system nios_system_Inst (
    .clk_clk                        (CLOCK1_50),        //   input,   width = 1,                     clk.clk

    .key_external_connection_export (),              //   input,   width = 4, key_external_connection.export
    .led_external_connection_export (),              //  output,  width = 10, led_external_connection.export
    .sw_external_connection_export  (),               //   input,  width = 10,  sw_external_connection.export
    .reset_reset_n                  (1'b1),             //   input,   width = 1,                   reset.reset_n

    .sdram_clk_clk                  (DRAM_CLK),         //  output,   width = 1,               sdram_clk.clk
    .sdram_cke                      (DRAM_CKE),         //  output,   width = 1,                   sdram.cke
    .sdram_cs_n                     (DRAM_CS_n),        //  output,   width = 1,                        .cs_n
    .sdram_ras_n                    (DRAM_RAS_n),       //  output,   width = 1,                        .ras_n
    .sdram_cas_n                    (DRAM_CAS_n),       //  output,   width = 1,                        .cas_n
    .sdram_we_n                     (DRAM_WE_n),        //  output,   width = 1,                        .we_n
    .sdram_dqm                      (DRAM_DQM),         //  output,   width = 4,                        .dqm
    .sdram_addr                     (DRAM_ADDR),        //  output,  width = 13,                        .addr
    .sdram_ba                       (DRAM_BA),          //  output,   width = 2,                        .ba
    .sdram_data_out                 (dram_data_out),    //  output,  width = 32,                        .data_out
    .sdram_data_oe                  (dram_data_oe),     //  output,   width = 1,                        .data_oe
    .sdram_data_in                  (dram_data_in)      //   input,  width = 32,                        .data_in
);



endmodule
