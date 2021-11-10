using System;
using System.IO;

class LanguageInterpreter
{
    // The command line argument passed in
    // from which we collect the filename
    private string[] _arguments;

    // The ascii character as integer
    private int _asciiCharacter;

    public LanguageInterpreter(string[] Arguments)
    {
        this._arguments = Arguments;
    }

    public void Interpret(string Source) {
        int CharacterIndex = 0;
        while(CharacterIndex < Source.Length)
        {
            char Character = Source[CharacterIndex];
            switch (Character)
            {
                case '+':
                    this._asciiCharacter += 1;
                    break;
                case '-':
                    this._asciiCharacter -= 1;
                    break;
                case ';':
                    CharacterIndex = Source.Length;
                    break;
                case '#':
                    // Cast the ascii character integer to a character
                    // and write it to the screen without a newline
                    char AsciiCharacter = (char) this._asciiCharacter;
                    Console.Write(AsciiCharacter);
                    break;
            }
            CharacterIndex++;
        }
    }

    public string GetSourceCode()
    {
        if (this._arguments.Length == 0) return "";
        string FileName = this._arguments[0];
        return File.ReadAllText(FileName);
    }
}


namespace Language
{
    class Interpreter
    {
        public static void Main(string[] args)
        {
            LanguageInterpreter interpreter = new LanguageInterpreter(args);
            interpreter.Interpret(interpreter.GetSourceCode());
        }

    }
}
