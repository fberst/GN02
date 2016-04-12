SC=./scripts

mkroot:
	${SC}/mkroot.sh

mkSD:
	SD=$1
	formatSD ${SD}
	cptosd ${SD}

clean:
	@rm -rf ./root/*
	
mkimg:
	@echo "TODO"

mountall:
	@echo "TODO"

initGN02:
	@echo "TODO"

fdisk:
	@echo "TODO"

cptosd:
	@echo "TODO"

help:
	@echo "TODO"



