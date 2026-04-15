//`timescale 1ns/1ps
`include "CBE_Interface.svh"
`include "CBE_Package.svh"
import mem_pkg::*;

module tb_top;
  bit Clk, rst;

  // CLK generation
  initial begin
    Clk = 0;
    forever #1 Clk = ~ Clk;
  end  

  mem_env env_inst;
  mem_if mem_if_inst(Clk, rst); 

  SinglePortRAM_SynchRandW DUT (
    .Data_in   (mem_if_inst.Data_in),
    .Address   (mem_if_inst.Address),
    .EN        (mem_if_inst.EN),
    .Clk       (Clk),
    .rst       (rst),
    .Data_out  (mem_if_inst.Data_out),
    .Valid_out (mem_if_inst.Valid_out)
  );

  virtual mem_if vif; 

  initial begin
    vif = mem_if_inst;
    env_inst = new(vif);
    
  // Rst generation

			rst = 1'b1;
      #2 rst = 1'b0;
      #2 rst = 1'b1;
 
    env_inst.run_env();
  $stop; 
  end

endmodule