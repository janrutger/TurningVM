from lexV2 import *
from emitV2 import *
from parseV2 import *
import sys

def main():
    print("Teeny Tiny Compiler")

    if len(sys.argv) != 2:
        #sys.exit("Error: Compiler needs source file as argument.")
        with open("/home/janrutger/git/TurningVM/TeenyStacks/test2.stacks", 'r') as inputFile:
            input = inputFile.read()
    else:
        with open(sys.argv[1], 'r') as inputFile:
            input = inputFile.read()
    

    # Initialize the lexer, emitter, and parser.
    lexer = Lexer(input)
    emitter = Emitter("out.c")
    parser = Parser(lexer, emitter)

    parser.program() # Start the parser.
    emitter.writeFile() # Write the output to file.
    print("Compiling completed.")

main()



