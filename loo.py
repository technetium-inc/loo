import sys

class LooException(Exception):
    def __init__(self, message):
        super().__init__(message)


class Language(object):
    def __init__(self, source_code):
        self.data = source_code
        self.line_number = 1
        self.tokens = []
        self.pos = 0

        self.memory_cell = 0

        self.lexer()

    def lexer(self):
        character = self.current_character()
        while character is not None:
            if character == "\n":
                self.line_number += 1
            elif character == "+":
                self.memory_cell += 1
            elif character == "-":
                self.memory_cell -= 1
            elif character == "#":
                print(chr(self.memory_cell), end='')
            else:
                raise LooException(f"Invalid character {character} at line {self.line_number}")
            self.pos += 1
            character = self.current_character()

    def current_character(self):
        if len(self.data) == self.pos:
            return None
        else:
            return self.data[self.pos]

class ArgumentParser(object):
    def __init__(self, argument):
        self.argument = argument
        self.length = len(self.argument)

        self.parse_arguments()

    def parse_arguments(self):
        if self.length == 0:
            return None
        
        filename = self.argument[0]
        if not filename.endswith(".loo"):
            raise LooException("Not a loo file")

        with open(filename,"r") as source_reader:
            lang = Language(source_reader.read())

argument = ArgumentParser(sys.argv[1:])

