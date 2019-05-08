vsim work.processor
add wave *

mem save -o /home/ayman/Desktop/Arch/exp.mem -f mti -data binary -addr decimal -startaddress 0 -endaddress 1048576 -wordsperline 1 /processor/ftch/mem/ram
mem load -i /home/ayman/Desktop/Arch/PipelinedProcessor/Testcases/NEW/OneOperandInstr.mem -startaddress 0 -endaddress 1048576 /processor/ftch/mem/ram

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
force -freeze sim:/processor/i_rst 0 0
run
run
run
run
run
run
run

