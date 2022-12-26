# **_Verilog Notes_**

# Verilog Data Types
This section discusses the data type used in Verilog.

## Nets
- Connections between hardware elements.
- Keyword: **wire**.
- Default value: **z**.

## Registers
- Data storage elements.
- Unlike a net, a register does not need a driver.
- Keyword: **reg**.
- Default value: **x**.

## Vectors
- Nets or reg data types can be declared as vectors: multiple bit widths, if not specified then they are scalar.
- Declared as [_high#_:_low#_], left number is MSB.

## Integer, Real, and Time Register Data Types
- ## Integer
- - Keyword: **integer**
- - used for purposes such as counting.
