SRCS := dbgstream.cpp
EXAMPLE_SRCS := example.cpp
OBJS := $(patsubst %.cpp,%.o,$(SRCS))
EXAMPLE_OBJS := $(patsubst %.cpp,%.o,$(EXAMPLE_SRCS))
CXX = g++
PREFIX = /usr/local
CFLAGS = -Wall
LDFLAGS =
LIBS =

UNAME = $(shell uname -a)
ifneq (,$(findstring MINGW, $(UNAME)))
	EXT = .exe
	TARGET := libdbgstream.a
else
	EXT =
	TARGET :=
endif

EXAMPLE_EXES := $(patsubst %.cpp,%$(EXT),$(EXAMPLE_SRCS))

.PHONY: all clean example install

all: $(TARGET)

$(TARGET) : $(OBJS)
	ar ru $@ $(OBJS)

%.o: %.c dbgstream.h
	$(CXX) -c $(CFLAGS) $< -o $@

install:
	cp $(TARGET) $(DESTDIR)$(PREFIX)/lib/$(TARGET)
	cp dbgstream.h $(DESTDIR)$(PREFIX)/include/dbgstream.h

examples: example$(EXT)

example$(EXT): example.o libdbgstream.a
	$(CXX) $(CFLAGS) $< -o $@ -L. -ldbgstream

clean:
	rm -f $(TARGET) $(OBJS) $(EXAMPLE_EXES) $(EXAMPLE_OBJS) *~
