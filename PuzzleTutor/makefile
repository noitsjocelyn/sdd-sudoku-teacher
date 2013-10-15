SOURCES    = tester.m Puzzle.m PuzzleUnitTests.m
OUTFILE    = test

CC         = clang
FRAMEWORKS = -framework Foundation
LIBS       = -lobjc
CFLAGS     = -Wall
OUT        = -o $(OUTFILE)

GNUCC      = gcc
GNUHEADS   = -I/c/GNUstep/GNUstep/System/Library/Headers
GNULIBS    = -L/c/GNUstep/GNUstep/System/Library/Libraries -lgnustep-base
GNUCFLAGS  = $(CFLAGS) -fconstant-string-class=NSConstantString -std=c99
WINOUT     = $(OUT).exe

FLAGS      = $(CFLAGS) $(FRAMEWORKS) $(LIBS)
GNUFLAGS   = $(GNUHEADS) $(GNULIBS) $(GNUFRAMES) $(GNUCFLAGS) $(LIBS)

all:
	$(CC) $(SOURCES) $(OUT) $(FLAGS)

windows:
	$(GNUCC) $(SOURCES) $(WINOUT) $(GNUFLAGS)

linux:
	$(GNUCC) $(SOURCES) $(OUT) $(GNUFLAGS)

clean:
	rm -f $(OUTFILE) $(OUTFILE).exe
