.PHONY: all

all: map.pdf map.png

map.pdf: map.svg
	inkscape --export-pdf=$@ $<

map.png: map.pdf
	convert -density 96 $< $@
