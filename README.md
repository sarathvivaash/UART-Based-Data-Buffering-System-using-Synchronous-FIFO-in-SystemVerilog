# UART-Based Data Buffering System Using a Parameterized Synchronous FIFO in SystemVerilog

## Overview 

This project implements a UART-based data buffering system using SystemVerilog. The main objective of the project is to receive serial UART data, convert it into parallel data using a UART receiver, temporarily store the received bytes in a parameterized synchronous FIFO, and read them back whenever required.

The project was developed to understand RTL design, finite state machines, FIFO operation, UART communication, and verification using SystemVerilog.



## Modules Used

### 1. Parameterized Synchronous FIFO
- Configurable data width and FIFO depth.
- Stores received UART data.
- Generates "full" and "empty" status signals.
- Supports synchronous read and write operations.

### 2. UART Receiver
- Receives serial UART data.
- Detects start and stop bits.
- Converts serial data into 8-bit parallel data.
- Generates a "data_valid" signal after receiving a complete byte.

### 3. UART FIFO Top Module
- Connects the UART receiver with the synchronous FIFO.
- Writes received UART bytes into the FIFO automatically.
- Allows the stored data to be read using the FIFO read interface.


## Working

1. UART serial data is received through the RX line.
2. The UART receiver converts the serial bits into an 8-bit parallel byte.
3. Once a byte is received successfully, the UART receiver generates "data_valid".
4. The received byte is written into the synchronous FIFO.
5. The stored data can later be read from the FIFO using the read enable signal.


## Verification

Each module was verified separately before integrating the complete system.

The following test cases were verified:

- UART data reception
- FIFO write operation
- FIFO read operation
- FIFO full condition
- FIFO empty condition
- Reset operation
- Top-level UART to FIFO integration


## Output Waveforms

Simulation waveforms are available in the "output waveforms" folder.


## Software Used

- SystemVerilog
- Xilinx Vivado 2025.2


## Future Improvements

- Add a UART Transmitter module.
- Implement an Asynchronous FIFO.
- Interface the design with APB or AXI.
- Implement the design on FPGA hardware.

