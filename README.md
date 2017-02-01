# GCCTranslationUnitParser

This is a parser that I created using ANTLR4. This parses the translation unit file generated by GCC when using the -fdump-translation-unit flag. My objective was to use semantic information of this file to improve AST construction. 

##How to compile?

-Enter in the SRC directory 

> cd src [enter]

- Call make file

> make [enter]


##How to use?

 - Call the tuparser binary inside BIN folder and pass as argument the file generated by G++ with the -fdump-translation-unit flag.

> bin/tuparser [filename].tu 

 -Example:

>	bin/tuparser bubblesort.cpp.001t.tu

##How to develop new things using Tuparser?

 - In the main.cpp code, you can implement your functions to navigate the generated AST.
 - In the thetuparser.g4 you can modify the grammar to insert new information or improve the generated AST.

##Contributors

 - Fell free to contribute for this project by forking this repository and sending pull requests. 

##Contact

 - If your have any question, please contact me: cleversonledur@gmail.com
