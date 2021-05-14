import 'dart:io';

class LooInterpreter {
  int position = 0;
  int ascii = 0;

  late String data;

  LooInterpreter(String data) {
    this.data = data;
  }

  void execute() {
    String character = this.currentCharacter();
    while(character != ";"){
      if(character == "+"){
        this.ascii += 1;
      } else if(character == "-"){
        this.ascii -= 1;
      } else if(character == "#") {
        stdout.write(String.fromCharCode(this.ascii));
      }

      this.position += 1;
      character = this.currentCharacter();
    }
  }

  String currentCharacter() {
    if(this.data.length == this.position) {
      return ";";
    } else {
      return this.data[this.position];
    }
  }
}

String createSource(List<String> arguments){
  if(arguments.length == 0){
    return "";
  }
  String filename = arguments[0];
  return filename;
}

void main(List<String> arguments) {
  String filename = createSource(arguments);
  if(filename.length == 0){
    print("No filename specified");
  } else {
    File(filename).readAsString().then((String content) {
      LooInterpreter interpreter = new LooInterpreter(content);
      interpreter.execute();
    });
  }
}
