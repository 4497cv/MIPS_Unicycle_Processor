onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk
add wave -noupdate /MIPS_Processor_TB/reset
add wave -noupdate /MIPS_Processor_TB/DUV/Instruction_Memory/Instruction
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/ALUResult
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadRegister1
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadRegister2
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteRegister
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteData
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadData1
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadData2
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/A
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/B
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {881 ps}
