vsim work.updwncntr
# vsim work.updwncntr 
# Start time: 18:59:38 on Apr 30,2019
# //  ModelSim DE 2019.1 Jan  1 2019 Linux 4.4.0-140-generic
# //
# //  Copyright 1991-2019 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  ModelSim DE and its associated documentation contain trade
# //  secrets and commercial or financial information that are the property of
# //  Mentor Graphics Corporation and are privileged, confidential,
# //  and exempt from disclosure under the Freedom of Information Act,
# //  5 U.S.C. Section 552. Furthermore, this information
# //  is prohibited from disclosure under the Trade Secrets Act,
# //  18 U.S.C. Section 1905.
# //
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.updwncntr(behavioral)
add wave *
force -freeze sim:/updwncntr/i_rst 1 0
force -freeze sim:/updwncntr/i_en 0 0
force -freeze sim:/updwncntr/i_dir 0 0
force -freeze sim:/updwncntr/i_step 0 0
force -freeze sim:/updwncntr/i_load 0 0
force -freeze sim:/updwncntr/i_cnt 0101 0
force -freeze sim:/updwncntr/i_clk 1 10, 0 {60 ps} -r 100
run
force -freeze sim:/updwncntr/i_rst 0 0
run
run
force -freeze sim:/updwncntr/i_en 1 0
run
force -freeze sim:/updwncntr/i_load 1 0
run
run
force -freeze sim:/updwncntr/i_step 0 0
run
run
force -freeze sim:/updwncntr/i_step 1 0
run
run
force -freeze sim:/updwncntr/i_dir 1 0
run
run
run
force -freeze sim:/updwncntr/i_step 0 0
run
force -freeze sim:/updwncntr/i_en 0 0
run
run
run