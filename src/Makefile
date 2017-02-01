ANTLRDIR		=../libraries/antlr4/
LOCATION		= $(ANTLRDIR)antlr4-4.5.4-SNAPSHOT.jar
RUNTIME			= $(ANTLRDIR)include
CC              = g++
CFLAGS          = -Wall -std=c++1y -g -pipe -O3 -fPIC -shared -Wattributes
LDFLAGS         =
IFLAGS          =-I../antlrcpp -I. -I$(RUNTIME) -I$(RUNTIME)/atn\
                 -I$(RUNTIME)/dfa -I$(RUNTIME)/misc -I$(RUNTIME)/tree\
                 -I$(RUNTIME)/tree/pattern -I$(RUNTIME)/tree/xpath\
                 -I$(RUNTIME)/support

NAME			= thetuparser

TARGET = ../bin/tuparser # name of the generated binary
INCLUDES = -I ../include -I ../dev 

all:
	rm generated -rf
	rm $(TARGET) -rf 
	mkdir -p generated
	java -jar $(LOCATION) -Dlanguage=Cpp -no-listener -no-visitor -Werror  -o generated/ -package antlrcpptest $(NAME).g4

	cp main.cpp generated/main.cpp

	$(CC) $(IFLAGS) $(CFLAGS) $(INCLUDES) $(STORECONTENT) $(VERBOSEFLAGS) -o generated/main.o generated/main.cpp -c $<

	$(CC) $(IFLAGS) $(CFLAGS) $(INCLUDES) $(STORECONTENT) $(VERBOSEFLAGS) -o generated/$(NAME)Lexer.o generated/$(NAME)Lexer.cpp -c $<
	$(CC) $(IFLAGS) $(CFLAGS) $(INCLUDES) $(STORECONTENT) $(VERBOSEFLAGS) -o generated/$(NAME)Parser.o generated/$(NAME)Parser.cpp -c

	$(CC) -Wall -pedantic -W -DNDEBUG $(STORECONTENT) $(VERBOSEFLAGS) -std=c++1y  generated/main.o  generated/$(NAME)Lexer.o generated/$(NAME)Parser.o  -o $(TARGET) -rdynamic $(ANTLRDIR)libantlr4-runtime.a -luuid


clean:
	rm generated -rf
	rm $(TARGET) -rf 


