install:
	wget http://nand2tetris.org/software/nand2tetris.zip
	unzip nand2tetris.zip
	rm nand2tetris.zip

%.zip:
	zip -j $@ nand2tetris/projects/$(subst .zip,,$@)/*?/?*.hdl
