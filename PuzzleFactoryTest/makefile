SOURCES    = main.m Puzzle.m PuzzleMaker.m PuzzleFactoryTests.m PuzzleMakerFactory.m ../SudokuGenerator/SudokuBoard.m ../SudokuGenerator/SudokuBoardGenerator.m ../SudokuGenerator/SudokuBoardSector.m ../SudokuGenerator/JFRandom.m
OUTFILE    = main

CC         = clang
FRAMEWORKS = -framework Foundation -fobjc-arc
LIBS       = -lobjc
CFLAGS     = -Wall
OUT        = -o $(OUTFILE)

GNUCC      = gcc
GNUHEADS   = -I/c/GNUstep/GNUstep/System/Library/Headers
GNULIBS    = -L/c/GNUstep/GNUstep/System/Library/Libraries -lgnustep-base
GNUCFLAGS  = $(CFLAGS) -fconstant-string-class=NSConstantString -std=c99 -fobjc-exceptions
WINOUT     = $(OUT).exe

FLAGS      = $(CFLAGS) $(FRAMEWORKS) $(LIBS)
GNUFLAGS   = $(GNUHEADS) $(GNULIBS) $(GNUFRAMES) $(GNUCFLAGS) $(LIBS)

all:
	$(CC) $(SOURCES) $(OUT) $(FLAGS)

windows:
	$(GNUCC) $(SOURCES) $(WINOUT) $(GNUFLAGS)

linux:
	$(CC) $(SOURCES) $(OUT) $(GNUFLAGS)

clean:
	rm -f $(OUTFILE) $(OUTFILE).exe
