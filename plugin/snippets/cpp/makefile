SHELL = powershell.exe
CC := g++
CFLAGS := -Wall -Werror
ifndef OPTLEVEL
	OPTLEVEL := -O0
endif

MAIN := main
BINARY := App.exe

TARGETDIR := ./target
SRCDIR := ./src
SOURCES := main.cpp

OBJECTS := $(subst .cpp,.o,$(SOURCES))

# TODO : Add include and library support in below commands
INCLUDEDIR := ./include
INCLUDES := 
LIBDIR := ./lib
LIBS := 

# Compiles Binary from object files
$(TARGETDIR)/$(BINARY): $(addprefix $(TARGETDIR)\, $(OBJECTS))
	$(CC) $(CFLAGS) $(addprefix $(TARGETDIR)\, $(OBJECTS)) -o $(TARGETDIR)/$(BINARY) $(OPTLEVEL) -L$(LIBDIR) $(addprefix $(LIBDIR)\\,$(LIBS))

# Compiles object files from source
$(TARGETDIR)\\%.o: $(SRCDIR)\\%.cpp $(addprefix $(INCLUDEDIR)\\,$(INCLUDES))
	$(CC) $(CFLAGS) $(SRCDIR)/$*.cpp -c -o $(TARGETDIR)/$*.o $(OPTLEVEL) -I$(INCLUDEDIR)

# Only checks for syntax correctness
check:
	$(CC) $(CFLAGS) $(addprefix $(SRCDIR)\, $(SOURCES)) -fsyntax-only -I$(INCLUDEDIR)

build: $(TARGETDIR)/$(BINARY)

run: $(TARGETDIR)/$(BINARY)
	./$(TARGETDIR)/$(BINARY)

clean: 
	&del -Force .\$(TARGETDIR)\*

$(TARGETDIR): 
	&mkdir ./$(TARGETDIR)/ -f | Out-Null
