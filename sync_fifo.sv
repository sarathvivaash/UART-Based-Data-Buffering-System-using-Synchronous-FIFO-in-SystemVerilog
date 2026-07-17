`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2026 12:49:51
// Design Name: 
// Module Name: sync_fifo
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


module sync_fifo #(parameter data_width = 8,parameter depth = 16)
(input logic clk, input logic reset_n, input logic write_enable, input logic read_enable, input logic [data_width-1:0] data_in, output logic [data_width-1:0] data_out,
 output logic empty, output logic full);
 
 logic [data_width-1:0] memory [depth-1:0];
 logic [$clog2(depth)-1:0] write_ptr;
 logic [$clog2(depth)-1:0] read_ptr;
 logic [$clog2(depth):0] count;
 
 assign full = (count == depth);
 assign empty = (count == 0);
 
 always_ff @(posedge clk or negedge reset_n) begin

  if (!reset_n) begin
    write_ptr <= 0;
    read_ptr <= 0;
    count <= 0;
    data_out <= 0;
  end
  else begin
    if(write_enable && !full && !read_enable) begin
    memory[write_ptr] <= data_in;
    write_ptr <= write_ptr + 1;
    count <= count + 1;
    end
    
    else if(read_enable && !empty && !write_enable) begin
     data_out <= memory[read_ptr];
     read_ptr <= read_ptr + 1;
     count <= count - 1;
    end
    
    else if(read_enable && write_enable) begin
     if(!empty) begin
      data_out <= memory[read_ptr];
      read_ptr <= read_ptr + 1;
     end
     
     if(!full) begin
     memory[write_ptr] <= data_in;
     write_ptr <= write_ptr +1;
     end
    end
  end
 end
endmodule
