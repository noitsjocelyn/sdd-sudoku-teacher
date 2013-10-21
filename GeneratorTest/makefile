# Copy this file into the folder you want to build and rename it "makefile".
# Change the SOURCES variable to a space-separated list of your .m files. Then
# change the OUTNAME variable to your desired binary file name.

SOURCES = tester.m GeneratorTests.m ../SudokuGenerator/JFRandom.m ../SudokuGenerator/SudokuBoard.m ../SudokuGenerator/SudokuBoardGenerator.m ../SudokuGenerator/SudokuBoardSector.m
OUTNAME    = test

CC         = clang
FRAMEWORKS = -framework Foundation
LIBS       = -lobjc
CFLAGS     = -Wall
OUT        = -o $(OUTNAME)

GNUCC      = gcc
GNUHEADS   = -I/c/GNUstep/GNUstep/System/Library/Headers
GNULIBS    = -L/c/GNUstep/GNUstep/System/Library/Libraries -fobjc-exceptions -lgnustep-base
GNUCFLAGS  = -fconstant-string-class=NSConstantString -std=c99 -Wno-unknown-pragmas -Wno-implicit-function-declaration
WINOUT     = $(OUT).exe

FLAGS      = $(CFLAGS) $(FRAMEWORKS) $(LIBS)
GNUFLAGS   = $(GNUHEADS) $(GNULIBS) $(GNUFRAMES) $(GNUCFLAGS) $(LIBS)

all:
	$(CC) $(SOURCES) $(OUT) $(FLAGS)

windows:
	# Unfortunately, JFRandom.m will not compile under GNUStep. Run these tests on OS X.
	# If you wish to attempt with GNUStep, run the command below:
	# $(GNUCC) $(SOURCES) $(WINOUT) $(GNUFLAGS)

linux:
	$(GNUCC) $(SOURCES) $(OUT) $(GNUFLAGS)

clean:
	rm -f $(OUTNAME) $(OUTNAME).exe
