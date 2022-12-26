# **_Verilog Notes_**

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
- Declared as [_high#_:_low#_] or [_low#_:_high#_], left number is MSB

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
