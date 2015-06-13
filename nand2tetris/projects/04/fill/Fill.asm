	// This file is part of www.nand2tetris.org
	// and the book "The Elements of Computing Systems"
	// by Nisan and Schocken, MIT Press.
	// File name: projects/04/Fill.asm

	// Runs an infinite loop that listens to the keyboard input.
	// When a key is pressed (any key), the program blackens the screen,
	// i.e. writes "black" in every pixel. When no key is pressed, the
	// program clears the screen, i.e. writes "white" in every pixel.

	// Put your code here.
	(LOOP) // beginning of the infinite loop
          @KBD //grabs the keyboard input at D
          D = M

          @color
          M = 0
          @white
          D; JEQ

          @0
          D = !A // all ones in binary
          @color
          M = D
          (white)

          @8192
          D = A
          @i
          M = D

          (INNER)
            @i // check if we should paint the next pixel
            D = M
            @END
            D; JLT

            @SCREEN // set A to the address of the current pixel
            D = A
            @i
            D = D + M
            @p
            M = D

            @color // set the pixel to the current color
            D = M
            @p
            A = M
            M = D

            @i // increment i
            M = M - 1

            @INNER // if we should not, just jump to start
            0; JEQ
          (END)
        @LOOP
        0; JEQ
