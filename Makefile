.PHONY: all

all: map.pdf

map.pdf: map.svg
	inkscape --export-pdf=$@ $<
