vlib work
vlog CBE_Lab_1.sv CBE_Tbench.sv
vsim -voptargs=+acc work.tb_top
add wave *
run -all
#quit -sim