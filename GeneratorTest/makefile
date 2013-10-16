# Copy this file into the folder you want to build and rename it "makefile".
# Change the SOURCES variable to a space-separated list of your .m files. Then
# change the OUTNAME variable to your desired binary file name.

SOURCES    = GeneratorTests.m
OUTNAME    = test

CC         = clang
FRAMEWORKS = -framework Foundation
LIBS       = -lobjc
CFLAGS     = -Wall
OUT        = -o $(OUTNAME)

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
