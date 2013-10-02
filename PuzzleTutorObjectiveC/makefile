SOURCE     = tester.m Puzzle.m
OUT        = -o test

CC         = clang
FRAMEWORKS = -framework Foundation -fobjc-arc
LIBS       = -lobjc
CFLAGS     = -Wall

GNUCC      = gcc
GNUHEADS   = -I/c/GNUstep/GNUstep/System/Library/Headers
GNULIBS    = -L/c/GNUstep/GNUstep/System/Library/Libraries -lgnustep-base
GNUFRAMES  = -fno-objc-arc
GNUCFLAGS := $(CFLAGS) -fconstant-string-class=NSConstantString -std=c99
WINOUT    := $(OUT).exe

FLAGS     := $(CFLAGS) $(FRAMEWORKS) $(LIBS)
GNUFLAGS  := $(GNUHEADS) $(GNULIBS) $(GNUFRAMES) $(GNUCFLAGS) $(LIBS)

all:
	$(CC) $(SOURCE) $(OUT) $(FLAGS)

windows:
	$(GNUCC) $(SOURCE) $(WINOUT) $(GNUFLAGS)

linux:
	$(GNUCC) $(SOURCE) $(OUT) $(GNUFLAGS)
