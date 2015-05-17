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
