install:
	wget http://nand2tetris.org/software/nand2tetris.zip
	unzip nand2tetris.zip
	rm nand2tetris.zip

define zip
	zip -j $@ $^
endef

PRJDIR := nand2tetris/projects

%.zip: $(PRJDIR)/%/*/?*
	$(zip)

%.zip: $(PRJDIR)/%/*
	$(zip)

assemble:
	$(PRJDIR)/06/assembler $(PRJDIR)/06/add/Add.asm \
		$(PRJDIR)/06/pong/Pong.asm \
		$(PRJDIR)/06/pong/PongL.asm \
		$(PRJDIR)/06/max/Max.asm \
		$(PRJDIR)/06/max/MaxL.asm \
		$(PRJDIR)/06/rect/Rect.asm \
		$(PRJDIR)/06/rect/RectL.asm

correct_assemble:
	nand2tetris/tools/Assembler.sh $(PRJDIR)/06/add/Add.asm
	nand2tetris/tools/Assembler.sh $(PRJDIR)/06/pong/Pong.asm
	nand2tetris/tools/Assembler.sh $(PRJDIR)/06/max/Max.asm
	nand2tetris/tools/Assembler.sh $(PRJDIR)/06/rect/Rect.asm
