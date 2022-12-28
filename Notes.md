# **_Verilog Notes_**
#### ***Book***: Verilog HDL: A Guideto Digital Design and Synthesis, _Samir Palnitkar_
---
# Verilog Data Types
This section discusses the data type used in Verilog.

## Nets
- connections between hardware elements
- Keyword: **wire**
- Default value: **z**

## Registers
- data storage elements
- unlike a net, a register does not need a driver
- Keyword: **reg**
- Default value: **x**
- stores _unsigned_ quantities

## Vectors
- nets or reg data types can be declared as vectors: multiple bit widths, if not specified then they are scalar
- Declared as [_high#_ : _low#_] or [_low#_ : _high#_], left number is MSB

## Integer, Real, and Time Register Data Types

### Integer
- Keyword: **integer**
- cannot have a range declaration
- used for purposes such as counting
- stores _signed_ quantities
- minimum size: 32 bits

### Real
- Keyword: **real**
- cannot have a range declaration
- Default vale: **0**
- when a real value is assigned to an integer, the real number is rounded off to the nearest integer

### Time
- used to store simulation time
- Keyword: **time**
- minimum size: 64 bits
- **$time** is invoked to get the current simulation time

### Arrays
- allowed for **reg**, **integer**, **time**, **real**, **realtime** and _vector_ register data type
- multi-dimensional array is also possible

### Memories
- one-dimensional array of registers

### Parameters
- Keyword: **parameter**
- used to declare constants

### Strings
- can be stored in **reg**
- width must be large enough to hold the string
- each character of string takes 8 bits(1 byte)
---
# System Tasks and Compiler Directives

## System Tasks

- Displaying information: **$display**
- - adds newline at the end of the string
- Monitoring information: **$monitor**
  - **$monitoron**: enables monitoring
  - **$monitoroff**: disables monitoring
- Stopping a simulation: **$stop**
- Finishing a simulation: **$finish**

## Compiler Directives

  - **\`define**: used to define text macros in Verilog
  - **\`include**: used to include entire contents of a Verilog source file in another file during compilation
---
# Port Connection Rules
## Input
- Internally: *net*
- Externally: **reg** or *net*

## Output
- Internally: **reg** or *net*
- Externally: **reg**

## Inout
- Internally and Externally: *net*

---
# Modelling Styles
## Gate Level Modelling
  - Directly by using gates(e.g. and, nand, nor, or etc.)
## Dataflow Modelling
  - By using expressions(&, |, ~, ^)
## Behavioral Modelling
  ### Structured Procedures
   - **initial** : An **initial** block starts at time 0, executes exactly once during a simulation, and then does not execute again. If there are multiple **inital** blocks, each block starts to execute concurrently at time 0. Each block finishes execution independently of other block. Multiple behavioral statements must be grouped, typically using the keywords **begin** and **end**, if there is only one behavioral statement, grouping is not needed. This is typically used for initialization, monitoring waveforms and other processes that must be executed only once during the entire simulation run.
  - **always** : The **always** statement starts at time 0 and executes the statements in the block continuously in a looping fashion. This statement is used to model a block of activity that is repeated continuously in a digital circuit.
  ### Procedural Assignments
   - Procedural assignments update values of **reg**, **integer**, **real**, or **time** variables. The value placed on a variable will remain unchanged until another procedural assignment updates the variable with e different value. This are unlike continuous assignments, _dataflow modelling_.
      - Blocking Assignment: using **=** symbol: executes sequencially
      - Non-blocking Assignment: using **<=** symbol: execute simultaneously. This is used as a method to model several concurrent data transfers that take place after a common event in digital design. Pipeline modelling and mutually exclusive data transfer.
      - - For digital design, use of non-blocking assignments in place of blocking assignments is highly recommended in places where concurrent data transfers take place after a common event. In such cases, blocking assignments can potentially cause race conditions because the final result depends on the order in whoch the assignments are evaluated. Non-blocking assignments can be used effectively to model concurrent data transfers because the final result is not dependent on the order in whoch the assignments are evaluated.

  ### Timing Controls
   - Delay-based timing control: using **#** symbol
   - Event-based timing control: using **@()** symbol
      - An event is triggered by using **->** symbol
   - Level-sensitive timing control: using **wait** keyword
