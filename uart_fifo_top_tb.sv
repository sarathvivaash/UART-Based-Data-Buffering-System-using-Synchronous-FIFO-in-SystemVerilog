`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2026 15:07:35
// Design Name: 
// Module Name: uart_fifo_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_fifo_top_tb;
  parameter clk_frequency = 100000000;
  parameter baud_rate = 115200;
  localparam clks_per_bit = clk_frequency/baud_rate;
  logic clk;
  logic reset_n;
  logic rx;
  logic read_enable;
  logic [7:0] data_out;
  logic empty;
  logic full;
  
  uart_fifo_top DUT (.clk(clk),.reset_n(reset_n),.rx(rx),.read_enable(read_enable),.data_out(data_out),.empty(empty),.full(full));
  
  always #5 clk = ~clk;
  
  task send(input [7:0] data);
   integer i;
   begin
     rx = 0;
     repeat(clks_per_bit)
       @(posedge clk);
     
     for(i=0; i<8; i=i+1)begin
        rx = data[i];
        repeat(clks_per_bit)
          @(posedge clk);
     end
     
     rx = 1;
     repeat(clks_per_bit)
       @(posedge clk);
    end
  endtask
  
  initial begin
    clk = 0;
    reset_n = 0;
    rx = 1;
    read_enable = 0;
    #20;
    reset_n = 1;
    
    send(8'h55);
    send(8'hA5);
    send(8'hFF);
    send(8'h00);
   
    repeat(20) @(posedge clk);
    
    read_enable = 1;
    @(posedge clk);
    read_enable = 0;
    @(posedge clk);
    $display("Read Data = %h", data_out);
    
    read_enable = 1;
    @(posedge clk);
    read_enable = 0;
    @(posedge clk);
    $display("Read Data = %h", data_out);
    
    read_enable = 1;
    @(posedge clk);
    read_enable = 0;
    @(posedge clk);
    $display("Read Data = %h", data_out);
    
    read_enable = 1;
    @(posedge clk);
    read_enable = 0;
    @(posedge clk);
    $display("Read Data = %h", data_out);
    
    
    #1000;
    $finish;
   end 
endmodule
