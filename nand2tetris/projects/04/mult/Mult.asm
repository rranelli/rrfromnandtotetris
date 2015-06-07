// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
@R2
M=0 // initialize result to be zero

@R0 // jump to the end if the value of R0 is zero
D=M

@END
D;JEQ

@R1 // jump to the end if the value of R1 is zero
D=M
@END
D;JEQ

@R1 // store the value of R1 into rone
D=M
@rone
M=D

(LOOP)
  @R2 // set D to the result so far
  D=M

  @R0 // add R0 to D
  D=D+M

  @R2 // write back the result of the sum to R2
  M=D

  @rone // decrement the value of `rone`
  M=M-1
  D=M // grap the value of `rone` to check if the loop should continue

  @END
  D=D-1;JLT // if `rone` is now -1 that means we have to stop the loop,

  @LOOP
  0;JMP // Back to the beginning
(END)

@END
0;JMP
