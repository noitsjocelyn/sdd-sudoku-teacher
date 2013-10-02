SOURCE = tester.m Puzzle.m
OUT    = -o test

CC         = clang
FRAMEWORKS = -framework Foundation
LIBS       = -lobjc
CFLAGS     = -Wall

GNUCC       = gcc
GNUHEADERS  = -I/c/GNUstep/GNUstep/System/Library/Headers
GNULIBS     = -L/c/GNUstep/GNUstep/System/Library/Libraries -lgnustep-base
CONSTSTRING = -fconstant-string-class=NSConstantString
GNUCFLAGS  := $(CFLAGS) -std=c99
WINOUT      = $(OUT).exe

FLAGS    := $(CFLAGS) $(FRAMEWORKS) $(LIBS)
GNUFLAGS := $(GNUHEADERS) $(GNULIBS) $(CONSTSTRING) $(GNUCFLAGS) $(LIBS)

all:
	$(CC) $(SOURCE) $(OUT) $(FLAGS)

windows:
	$(GNUCC) $(SOURCE) $(WINOUT) $(GNUFLAGS)

linux:
	$(GNUCC) $(SOURCE) $(OUT) $(GNUFLAGS)
