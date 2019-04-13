vsim -gui work.oneoperandalu
# vsim -gui work.oneoperandalu 
# Start time: 23:07:28 on Apr 13,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.oneoperandalu(oneoperandaluarch)
# Loading work.mux8x1(mux8x1arch)
# Loading work.mux4x1(mux4x1arch)
# Loading work.mux2x1(mux2x1arch)
# Loading work.fulladder(fulladderarch)
# Loading work.adder(adderarch)
add wave sim:/oneoperandalu/*
force -freeze sim:/oneoperandalu/a 0F0F 0
force -freeze sim:/oneoperandalu/s 0 0
force -freeze sim:/oneoperandalu/flagsIn 0 0
run

force -freeze sim:/oneoperandalu/s 1 0 
run
force -freeze sim:/oneoperandalu/s 2 0 
run
force -freeze sim:/oneoperandalu/s 3 0 
run
force -freeze sim:/oneoperandalu/s 4 0 
run
force -freeze sim:/oneoperandalu/s 5 0 
force -freeze sim:/oneoperandalu/a 0001 0
run