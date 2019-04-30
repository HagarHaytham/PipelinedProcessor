vsim work.circuitpc
add wave *
force -freeze sim:/circuitpc/i_rst 1 0
force -freeze sim:/circuitpc/i_stall 0 0
force -freeze sim:/circuitpc/i_dir 0 0
force -freeze sim:/circuitpc/i_step 0 0
force -freeze sim:/circuitpc/i_sel 0 0
force -freeze sim:/circuitpc/i_adrs 01010000 0
force -freeze sim:/circuitpc/i_clk 1 10, 0 {60 ps} -r 100
run
force -freeze sim:/circuitpc/i_rst 0 0
run
run
force -freeze sim:/circuitpc/i_stall 1 0
run
run
force -freeze sim:/circuitpc/i_stall 1 0
force -freeze sim:/circuitpc/i_stall 0 0
run
run
run
force -freeze sim:/circuitpc/i_sel 1 0
run
run
run
force -freeze sim:/circuitpc/i_step 1 0
run
run
run
force -freeze sim:/circuitpc/i_sel 0 0
force -freeze sim:/circuitpc/i_step 0 0
run
run
run
run
run
force -freeze sim:/circuitpc/i_sel 1 0
run
run
run
run
run
force -freeze sim:/circuitpc/i_dir 1 0
run
run
run
force -freeze sim:/circuitpc/i_step 1 0
run
run
run
run