vsim -gui work.loadstoredetection
add wave -position insertpoint sim:/loadstoredetection/*

# packet0 LDD R1,R2  NOP
# packet1 STD R2,R3  NOP  --src
force -freeze sim:/loadstoredetection/packet0 00000000000000001001100010010000 0
force -freeze sim:/loadstoredetection/packet1 00000000000000001010000100011000 0
run

# packet0 LDD R1,R2  NOP
# packet1 NOP  STD R2,R3   --src
force -freeze sim:/loadstoredetection/packet0 00000000000000001001100010010000 0
force -freeze sim:/loadstoredetection/packet1 10100001100100000000000000000000 0
run

# packet0 LDD R1,R2  NOP
# packet1 NOP  STD R3,R2 -- dst  
force -freeze sim:/loadstoredetection/packet0 00000000000000001001100010010000 0
force -freeze sim:/loadstoredetection/packet1 10100001000110000000000000000000 0
run

# packet0  NOP LDD R1,R2 
# packet1 STD R2,R3  NOP  --src
force -freeze sim:/loadstoredetection/packet0 10011000100100000000000000000000 0
force -freeze sim:/loadstoredetection/packet1 00000000000000001010000100011000 0
run

# packet0  NOP LDD R1,R2 
# packet1 NOP  STD R2,R3   --src
force -freeze sim:/loadstoredetection/packet0 10011000100100000000000000000000 0
force -freeze sim:/loadstoredetection/packet1 10100001100100000000000000000000 0
run


force -freeze sim:/loadstoredetection/packet0 00000000000000001101100010010000 0
run