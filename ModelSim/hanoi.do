onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {ALU OP}
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnitControl/ALUOp
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/ALUResult
add wave -noupdate -divider {Tower A}
add wave -noupdate -label 0x10010008 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[8]}
add wave -noupdate -label 0x10010004 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[4]}
add wave -noupdate -label 0x10010000 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[0]}
add wave -noupdate -divider {Tower B}
add wave -noupdate -label 0x10010028 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[40]}
add wave -noupdate -label 0x10010024 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[36]}
add wave -noupdate -label 0x10010020 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[32]}
add wave -noupdate -divider {Tower C}
add wave -noupdate -label 0x10010048 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[72]}
add wave -noupdate -label 0x10010044 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[68]}
add wave -noupdate -label 0x10010040 {/MIPS_Processor_TB/DUV/RAMDataMemory/ram[64]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {132 ps} 0}
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
WaveRestoreZoom {690 ps} {754 ps}
