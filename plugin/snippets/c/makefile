SHELL = powershell.exe
CC := gcc
CFLAGS := -Wall -Werror
OPTLEVEL := -O0

MAIN := main
BINARY := App.exe

TARGETDIR := .\target
SRCDIR := .\src
INCLUDES := .\include
LIBRARIES := .\lib

$(TARGETDIR)/$(BINARY): $(TARGETDIR)/$(MAIN).o
	$(CC) $(CFLAGS) $(TARGETDIR)/$(MAIN).o -o $(TARGETDIR)/$(BINARY) $(OPTLEVEL)

$(TARGETDIR)/$(MAIN).o: $(SRCDIR)/$(MAIN).c | $(TARGETDIR)
	$(CC) $(CFLAGS) $(SRCDIR)/$(MAIN).c -c -o $(TARGETDIR)/$(MAIN).o $(OPTLEVEL)

run: $(TARGETDIR)/$(BINARY)
	./$(TARGETDIR)/$(MAIN).exe

clean: 
	&del -Force .\$(TARGETDIR)\*

$(TARGETDIR): 
	&mkdir ./$(TARGETDIR)/ -f | Out-Null
