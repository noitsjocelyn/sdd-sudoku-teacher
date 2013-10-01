CC    = clang
WINCC = gcc

FRAMEWORKS := -framework Foundation
LIBRARIES  := -lobjc
WINFLAGS   := 

LDFLAGS := $(LIBRARIES) $(FRAMEWORKS)
CFLAGS  := -Wall

SOURCE = test.m Puzzle.m
OUT    = test

all:
	$(CC) $(LDFLAGS) $(CFLAGS) $(SOURCE) -o $(OUT)

windows:
	$(WINCC) $(SOURCE) $(WINFLAGS) -o $(OUT)
