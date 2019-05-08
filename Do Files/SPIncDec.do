vsim work.circsp
# vsim work.circsp 
# Start time: 06:57:59 on May 08,2019
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
# Loading work.circsp(behavioral)
# Loading ieee.std_logic_arith(body)
# Loading ieee.std_logic_unsigned(body)
# Loading work.updwncntr(behavioral)
add wave *
force -freeze sim:/circsp/i_rst 1 0
force -freeze sim:/circsp/i_opcd 0000 0
force -freeze sim:/circsp/i_clk 1 10, 0 {60 ps} -r 100
run
force -freeze sim:/circsp/i_rst 0 0
run
run
run
force -freeze sim:/circsp/i_opcd 10 0
run
run
run
run
force -freeze sim:/circsp/i_opcd 0 0
run
run
run
run
run
force -freeze sim:/circsp/i_opcd 11 0
run
run
run
run
run
run
run
run