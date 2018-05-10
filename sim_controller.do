



cd {C:/FPGA/FPGA 2014/vhdl_workspace/Controller}

vcom -reportprogress 300 -work work {C:/FPGA/FPGA 2014/vhdl_workspace/Controller/Controller.vhd}
vcom -reportprogress 300 -work work {C:/FPGA/FPGA 2014/vhdl_workspace/Controller/controller_tb.vhd}
vcom -reportprogress 300 -work work {C:/FPGA/FPGA 2014/vhdl_workspace/Controller/Types.vhd}

vsim work.controller_tb -t ns \
	-novopt 

add wave -noupdate -divider TOP_controller
add wave -noupdate -format Literal -radix unsigned /controller_tb/CLK
add wave -noupdate -format Literal -radix hexadecimal /controller_tb/DATA_IN
add wave -noupdate -format Literal -radix hexadecimal /controller_tb/DATA_OUT
add wave -noupdate -format Literal -radix hexadecimal /controller_tb/MEM_ADR
add wave -noupdate -format Literal -radix unsigned /controller_tb/MEM_WE
add wave -noupdate -format Literal -radix unsigned /controller_tb/MEM_EN

add wave -noupdate -divider internal_signals
add wave -noupdate /controller_tb/uut/state
add wave -noupdate /controller_tb/uut/next_state
add wave -noupdate /controller_tb/uut/CLK_MODIFIED
add wave -noupdate /controller_tb/uut/BYTE_READY_DELAYED
add wave -noupdate -format Literal -radix hexadecimal /controller_tb/uut/writeadr
add wave -noupdate -format Literal -radix hexadecimal /controller_tb/uut/readadr
add wave -noupdate -format Literal -radix hexadecimal /controller_tb/uut/stall
add wave -noupdate -format Literal -radix unsigned /controller_tb/uut/FQD


WaveRestoreZoom {0 ns} {500 us}


run 500 us