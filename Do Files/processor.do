vsim work.processor
# vsim work.processor 
# Start time: 07:59:36 on May 04,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.processor(struct)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.fetchcirc(struct)
# Loading work.fetchcontrol(behavioral)
# Loading work.circuitpc(behavioral)
# Loading work.updwncntr(behavioral)
# Loading ieee.numeric_std(body)
# Loading work.ram(syncram)
# Loading work.nreg(nregarch)
add wave *
mem load -filltype value -filldata 0010000010001000 -fillradix binary /processor/ftch/mem/ram(1)
mem load -filltype value -filldata 0010100110011000 -fillradix binary /processor/ftch/mem/ram(2)
mem load -filltype value -filldata 0100100010011000 -fillradix binary /processor/ftch/mem/ram(3)
force -freeze sim:/processor/i_input 0 0
force -freeze sim:/processor/i_rst 1 0
force -freeze sim:/processor/i_clkC 1 10, 0 {60 ps} -r 100
force -freeze sim:/processor/i_clkM 1 20, 0 {70 ps} -r 100
run
force -freeze sim:/processor/i_rst 0 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 520 ps  Iteration: 0  Instance: /processor/ftch/mem
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 620 ps  Iteration: 0  Instance: /processor/ftch/mem
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 720 ps  Iteration: 0  Instance: /processor/ftch/mem
run

restart
mem load -filltype value -filldata 1001100010000000 -fillradix binary /processor/ftch/mem/ram(0)
mem load -filltype value -filldata 0010000010001000 -fillradix binary /processor/ftch/mem/ram(1)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /processor/ftch/mem/ram(2)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /processor/ftch/mem/ram(3)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /processor/ftch/mem/ram(4)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /processor/ftch/mem/ram(5)
mem load -filltype value -filldata 1010000000001000 -fillradix binary /processor/ftch/mem/ram(6)
mem load -filltype value -filldata 0000000000000000 -fillradix binary /processor/ftch/mem/ram(7)
mem load -filltype value -filldata 1111 -fillradix hexadecimal /processor/mem/mem/ram(0)
force -freeze sim:/processor/i_rst 1 0
force -freeze sim:/processor/i_input 0 0
force -freeze sim:/processor/i_clkC 1 10, 0 {60 ps} -r 100
force -freeze sim:/processor/i_clkM 1 20, 0 {70 ps} -r 100
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es).
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /processor/aluU/top
force -freeze sim:/processor/i_rst 0 0
run
run
run