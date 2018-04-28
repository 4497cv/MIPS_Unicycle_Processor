onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {ALU OP}
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnitControl/ALUOp
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/ALUResult
add wave -noupdate -divider {Tower A}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[7]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[6]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[5]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[4]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[3]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[2]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[1]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[0]}
add wave -noupdate -divider {Tower B}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[15]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[14]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[13]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[12]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[11]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[10]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[9]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[8]}
add wave -noupdate -divider {Tower C}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[23]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[22]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[21]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[20]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[19]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[18]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[17]}
add wave -noupdate {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[16]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 135
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {24 ps}
