onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider PC
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/PROGRAM_COUNTER/PCValue
add wave -noupdate -divider {ALU CONTROL}
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnitControl/ALUOp
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnitControl/ALUFunction
add wave -noupdate -divider ALU
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/A
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/B
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/Zero
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/ALUResult
add wave -noupdate -divider {DATA MEMORY}
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/RAMDataMemory/Address
add wave -noupdate -radix hexadecimal /MIPS_Processor_TB/DUV/RAMDataMemory/WriteData
add wave -noupdate /MIPS_Processor_TB/DUV/RAMDataMemory/ReadData
add wave -noupdate /MIPS_Processor_TB/DUV/RAMDataMemory/ReadDataAux
add wave -noupdate -divider BRANCH
add wave -noupdate /MIPS_Processor_TB/DUV/BranchEqOrBranchNE/C
add wave -noupdate -divider CONTROL
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/ControlUnit/RegDst
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/BranchEQ
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/BranchNE
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/MemRead
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/ControlUnit/MemtoReg
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/MemWrite
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/ControlUnit/ALUSrc
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/RegWrite
add wave -noupdate /MIPS_Processor_TB/DUV/ControlUnit/Jump
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/ControlUnit/ALUOp
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/ControlUnit/ControlValues
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {24 ps}
