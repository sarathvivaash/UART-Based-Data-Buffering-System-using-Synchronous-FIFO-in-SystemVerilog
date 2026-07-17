`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 23:30:24
// Design Name: 
// Module Name: uart_rx
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


module uart_rx #( parameter clk_freq = 100000000, parameter baud_rate = 115200)
(input logic clk, input logic reset_n, input logic rx, output logic [7:0] data_out, output logic data_valid);
localparam clks_per_bit = clk_freq/baud_rate;

logic [$clog2(clks_per_bit)-1:0] clk_count;
logic [2:0] bit_index;
logic [7:0] shift_reg;

typedef enum logic [1:0]{IDLE, START, DATA, STOP} state_t;
state_t state;

always_ff @(posedge clk or negedge reset_n) begin
  if(!reset_n) begin
    state <= IDLE;
    clk_count <= 0;
    bit_index <= 0;
    shift_reg <= 0;
    data_out <= 0;
    data_valid <= 0;
  end
  else begin
   case(state)
     IDLE: begin
       data_valid <= 0;
       if(rx == 0) begin
         state <= START;
         clk_count <= 0;
       end
     end
     
     START: begin
       if(clk_count == (clks_per_bit/2)-1) begin
         if(rx == 0) begin
           state <= DATA;
           clk_count <= 0;
           bit_index <= 0;
         end
         else begin
           state <= IDLE;
         end
       end
       else begin 
         clk_count <= clk_count +1;
       end
      end
     
     DATA: begin
       if(clk_count == clks_per_bit - 1) begin
         clk_count <= 0;
         shift_reg[bit_index] <= rx;
         
         if(bit_index == 7) begin
           bit_index <= 0;
            clk_count <= 0;
           state <= STOP;
         end
         else begin
           bit_index <= bit_index + 1;
         end
       end
       else begin
         clk_count <= clk_count + 1;
       end
     end 
     
     STOP: begin
       if(clk_count == clks_per_bit -1) begin
         clk_count <= 0;
         
         if(rx == 1) begin
           data_out <= shift_reg;
           data_valid <= 1;
         end
         state <= IDLE;
       end
       else begin
         clk_count <= clk_count + 1;
       end
     end 
    endcase
  end
end
endmodule
