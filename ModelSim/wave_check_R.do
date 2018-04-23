onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk
add wave -noupdate /MIPS_Processor_TB/reset
add wave -noupdate -label PCSRC -radix symbolic /MIPS_Processor_TB/DUV/BranchEqOrBranchNE/C
add wave -noupdate -label {RESULT PC + 4} -radix binary /MIPS_Processor_TB/DUV/PC_4_adder/Result
add wave -noupdate -label {OFFSET SELECT} /MIPS_Processor_TB/DUV/MUX_Offset/Selector
add wave -noupdate -label MUX_OFFSET_OUT -radix binary /MIPS_Processor_TB/DUV/MUX_Offset/MUX_Output
add wave -noupdate -label offset_wire -radix binary /MIPS_Processor_TB/DUV/PCMUX_OFFSET_wire
add wave -noupdate -radix binary -childformat {{{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[31]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[30]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[29]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[28]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[27]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[26]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[25]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[24]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[23]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[22]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[21]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[20]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[19]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[18]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[17]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[16]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[15]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[14]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[13]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[12]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[11]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[10]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[9]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[8]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[7]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[6]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[5]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[4]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[3]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[2]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[1]} -radix binary} {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[0]} -radix binary}} -subitemconfig {{/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[31]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[30]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[29]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[28]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[27]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[26]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[25]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[24]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[23]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[22]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[21]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[20]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[19]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[18]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[17]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[16]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[15]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[14]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[13]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[12]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[11]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[10]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[9]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[8]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[7]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[6]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[5]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[4]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[3]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[2]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[1]} {-height 16 -radix binary} {/MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC[0]} {-height 16 -radix binary}} /MIPS_Processor_TB/DUV/PROGRAM_COUNTER/NewPC
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/PROGRAM_COUNTER/PCValue
add wave -noupdate -radix binary /MIPS_Processor_TB/DUV/Instruction_Memory/Instruction
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/ALUResult
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadRegister1
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadRegister2
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteRegister
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteData
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadData1
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/ReadData2
add wave -noupdate -label {ALU: A} /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/A
add wave -noupdate -label {ALU: B} /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/B
add wave -noupdate -label {SGN INPUT} -radix binary /MIPS_Processor_TB/DUV/SignExtender/DataInput
add wave -noupdate -label {SGN OUTPUT} -radix binary /MIPS_Processor_TB/DUV/SignExtender/SignExtendOutput
add wave -noupdate -label {SLL INPUT} -radix binary /MIPS_Processor_TB/DUV/ShiftLeft/DataInput
add wave -noupdate -label {SLL OUTPUT} -radix binary /MIPS_Processor_TB/DUV/ShiftLeft/DataOutput
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23 ps} 0}
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
WaveRestoreZoom {51 ps} {59 ps}
