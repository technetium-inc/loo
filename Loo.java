import java.io.FileNotFoundException;
import java.io.File;
import java.util.Scanner;

public class Loo {
    public static void main(String[] args) throws Exception {
        var parser = new ArgumentParser(args);
        String content = parser.getFilecontent();
        System.out.println(content);
    }

    static class Position {
        private int position;

        Position(int position) {
            this.position = position;
        }

        public int increment(int incrementBy) {
            this.position += incrementBy;
            return this.position;
        } 

        public char currentCharacter(String data) {
            if(data.length() == this.position){
                return ';';
            } else {
                return data.charAt(this.position);
            }
        }
    }

    static class LooInterpreter {
        private String data;

        public LooInterpreter(String data){
            this.data = data;
            this.createInterpreter();
        }

        public int createInterpreter() {
            int ascii = 0;
            for(int index=0; index<this.data.length(); index++){
                char character = this.data.charAt(index);
                if (character == '+'){
                    ascii += 1;
                } else if (character == '-'){
                    ascii -= 1;
                } else if(character == '#'){
                    System.out.println((char)ascii);
                } else if(character == ';'){
                    return 0;
                }
            }
            return 0;
        }
    }

    static class ArgumentParser {
        private String[] arguments;
        private int length;

        public ArgumentParser(String[] arguments){
            this.arguments = arguments;
            this.length = this.arguments.length;
        }

        private String getFilename() {
            if(this.length == 0) {
                return "";
            } else {
                return this.arguments[this.length-1];
            }
        }

        private String getFilecontent() {
            try {
                String data = "";
                File file = new File(this.getFilename());
                Scanner reader = new Scanner(file);
                while (reader.hasNextLine()) {
                  data = reader.nextLine();
                }
                reader.close();
                return data;
              } catch (FileNotFoundException e) {
                System.out.println(this.getFilename());
                e.printStackTrace();
            }
            return "";
        }
    }
}
