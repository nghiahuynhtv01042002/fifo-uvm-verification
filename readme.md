# FIFO Verification using SystemVerilog and UVM
## Introduction
This project verifies a synchronous FIFO design using SystemVerilog and UVM.
The goal is to demonstrate DV methodology including driver, monitor,
scoreboard, and functional coverage.
## Feature 
- SystemVerilog RTL FIFO
- UVM testbench
- Driver / Monitor / Agent architecture
- Scoreboard checking
- Randomized stimulus
- Functional coverage

## Project Structure
In a normal verification project the directory structure would be:

```
fifo-uvm/
│
├── rtl/
│   └── fifo.sv
│
├── interface/
│   └── fifo_if.sv
│
├── pkg/
│   └── fifo_pkg.sv
│
├── tb/
│   ├── seq_item/
│   ├── sequence/
│   ├── driver/
│   ├── monitor/
│   ├── agent/
│   ├── scoreboard/
│   ├── env/
│   └── test/
│
└── sim/
    └── tb_top.sv
```
Because **EDA Playground does not support directory structures**, all files are placed in a **single workspace**.  
To keep the project organized, file names use prefixes to represent the original directory.

Example mapping:

| Original Folder | File Naming in EDA Playground |
|-----------------|-------------------------------|
| rtl/            | rtl_fifo.sv                   |
| interface/      | if_fifo_if.sv                 |
| pkg/            | pkg_fifo_pkg.sv               |
| tb/driver       | drv_fifo_driver.sv            |
| tb/monitor      | mon_fifo_monitor.sv           |
| tb/agent        | agt_fifo_agent.sv             |
| tb/sequence     | seq_fifo_sequence.sv          |
| tb/seq_item     | seq_fifo_item.sv              |
| tb/scoreboard   | scb_fifo_scoreboard.sv        |
| tb/env          | env_fifo_env.sv               |
| tb/test         | test_fifo_test.sv             |
| sim/            | tb_top.sv                     |

## FIFO Specification

- Data width: 8 bits
- Depth: 16 entries
- Synchronous design
- Flags:
  - full
  - empty

## Verification Architecture
Testbench components:

- sequence_item
- sequence
- driver
- monitor
- agent
- scoreboard
- environment
- test

### Flow: 
```
sequence → driver → DUT → monitor → scoreboard
```

## Run Simulation

The simulation can be executed on EDA Playground.

Steps:
1. Open EDA Playground
2. Select simulator (Questa / VCS)
3. Enable UVM library
4. Add all source files
5. Run simulation

EDA Playground link: <[here](https://www.edaplayground.com/)>

## Example Simulation Output

<paste test picture and log here>