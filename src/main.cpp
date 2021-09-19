#include <fstream>
#include <iostream>

class Interpreter {
public:
  std::string source;

  /**
  Get the name of the file from the command line
  arguments passed in. returns null if a filename is
  not given;
  */
  static std::string getFileName(const char *argv[], int length) {
    if (length == 1)
      return nullptr;
    return argv[1];
  }

  /**
  Returns the content of the file.
  */
  static std::string getFileContent(const std::string filename) {
    std::ifstream file(filename);
    std::string fileContent = "";
    std::string currentLine;
    while (getline(file, currentLine)) {
      fileContent += currentLine;
    }
    file.close();
    return fileContent;
  }

  Interpreter(const std::string source) {
    this->source = source;
    interpret();
  }

private:
  void interpret() {
    int asciiCharacter = 0;
    for (int index = 0; index < source.length(); index++) {
      const char currentCharacter = source[index];
      switch (currentCharacter) {
      case '+':
        asciiCharacter += 1;
        break;
      case '-':
        asciiCharacter -= 1;
        break;
      case ';':
        exit(1);
        break;
      case '#':
        printf("%c", (char)asciiCharacter);
        break;
      }
    }
  }
};

int main(int argc, const char *argv[]) {
  const std::string filename = Interpreter::getFileName(argv, argc);
  const std::string fileContent = Interpreter::getFileContent(filename);

  const Interpreter interpreter = *new Interpreter(fileContent);
  return 0;
}
