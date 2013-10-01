CC    = clang
WINCC = gcc

FRAMEWORKS = -framework Foundation
LIBS       = -lobjc
CFLAGS     = -Wall
OUT        = -o test

GNUHEADERS  = -I/c/GNUstep/GNUstep/System/Library/Headers
GNULIBS     = -L/c/GNUstep/GNUstep/System/Library/Libraries -lgnustep-base
CONSTSTRING = -fconstant-string-class=NSConstantString
WINCFLAGS  := $(CFLAGS) -std=c99
WINOUT      = $(OUT).exe


FLAGS    := $(CFLAGS) $(FRAMEWORKS) $(LIBRARIES)
WINFLAGS := $(GNUHEADERS) $(GNULIBS) $(CONSTSTRING) $(WINCFLAGS) $(LIBS)
SOURCE    = tester.m Puzzle.m

all:
	$(CC) $(SOURCE) $(OUT) $(FLAGS)

windows:
	$(WINCC) $(SOURCE) $(WINOUT) $(WINFLAGS)
