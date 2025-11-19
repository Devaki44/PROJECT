# 
# run -all
# [5000] sel0=xxxxx sel1=xxxxx sel2=xxxxx sel3=xxxxx sel4=xxxxx | req0=0 req1=0 req2=0 req3=0 req4=0
# RESET DEASSERTED
# 
# [15000] sel0=00000 sel1=00000 sel2=00000 sel3=00000 sel4=00000 | req0=0 req1=0 req2=0 req3=0 req4=0
# ====================================
#      TESTCASE 1 : IN ? OUT        
# ====================================
# 
# Sending packet IN = 0 ? OUT = 2
# [25000] sel0=00000 sel1=00000 sel2=00000 sel3=00000 sel4=00000 | req0=1 req1=0 req2=0 req3=0 req4=0
# [35000] sel0=00000 sel1=00000 sel2=00001 sel3=00000 sel4=00000 | req0=1 req1=0 req2=0 req3=0 req4=0
# >>> OUT2 : 111000002
# [45000] sel0=00000 sel1=00000 sel2=00001 sel3=00000 sel4=00000 | req0=1 req1=0 req2=0 req3=0 req4=0
# >>> OUT2 : 111000003
# -------------------------------------------------------------------------------------------------------------------
# 
# Sending packet IN = 3 ? OUT = 3
# [55000] sel0=00000 sel1=00000 sel2=00001 sel3=00000 sel4=00000 | req0=0 req1=0 req2=0 req3=1 req4=0
# [65000] sel0=00000 sel1=00000 sel2=00000 sel3=01000 sel4=00000 | req0=0 req1=0 req2=0 req3=1 req4=0
# >>> OUT3 : 111000002
# [75000] sel0=00000 sel1=00000 sel2=00000 sel3=01000 sel4=00000 | req0=0 req1=0 req2=0 req3=1 req4=0
# >>> OUT3 : 111000003
# -------------------------------------------------------------------------------------------------------------------
# ** Note: $finish    : testbench.sv(147)
#    Time: 75 ns  Iteration: 1  Instance: /tb_cb
# End time: 11:28:27 on Nov 19,2025, Elapsed time: 0:00:01
# Errors: 0, Warnings: 0
End time: 11:28:27 on Nov 19,2025, Elapsed time: 0:00:01
*** Summary *********************************************
    qrun: Errors:   0, Warnings:   0
    vlog: Errors:   0, Warnings:   0
    vopt: Errors:   0, Warnings:   1
    vsim: Errors:   0, Warnings:   0
  Totals: Errors:   0, Warnings:   1
Done
