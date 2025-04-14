# RISCV-by-VERILOG
## Specifications of Single Cycle RISC-V
##### 1) The Textbook: https://drive.google.com/file/d/1tJ9ePCksqtPpuxykxGQ71NZINlt1PNlT/view
##### 2) The processor implements the following subset of the RV32I instruction set: 
    1) R-Type: add, sub, and, or 
    2) I-Type: addi, andi, ori, lw, jalr 
    3) B-Type: beq, bne 
    4) J-Type: jal 
    5) S-Type: sw
##### 3) The Assembly code in riscv.mem, which is used in instr_mem:
![image](https://github.com/user-attachments/assets/d6d6ecec-e847-4664-8998-44ee00efa4c0)


## Block Diagram 
![image](https://github.com/user-attachments/assets/15f03ddd-e115-48c5-87cc-110685896e1e)


## Simulation 
  ##### The Waveform of the first 6 instructions in assembly code in Questa-Sim:
![image](https://github.com/user-attachments/assets/6c682c06-4b1f-4cc3-b634-dc6accec3144)
  ##### The Explanation
  1) first instruction is immediate addition of x0 and 5 so alu_res = 5 and saved in x2 register. PC =0
  2) second instruction is immediate addition of x0 and 12 so alu_res = 12 and saved in x3 register. PC=4
  3) third instruction is immediate addition of x3 and 9 so alu_res = 12-9=3 and saved in x7 register. PC=8
  4) forth instruction is or operation between x7 and x2 so alu_res = 3(011) | 5(101) = 7(111) and saved in x4 register. PC=C
  5) fifth instruction is and operation between x3 and x4 so alu_res = 12(1100) & 7(111) = 4(0100) and saved in x5 register. PC=10
  6) sixth instruction is add operation between x5 and x4 so alu_res = 4 + 7 = 11 and saved in x5 register then x5 was updated from 4 to 11. PC=14
 
 
 




 
