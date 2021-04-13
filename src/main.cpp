#include <iostream>
#include <fstream>

class LooException {
    public:
    std::string message;
    int line_number;

    LooException(std::string message, int line) {
        this->message = message;
        this->line_number = line;
    }

    int throw_exception(int exit_status, bool fatal){
        std::cout << "[Error] " << this->message << " at line " <<this->line_number;
        if(fatal){
            std::exit(exit_status);
        }
        return exit_status;
    }
};


class FileReader {
    public:
    std::string filename;

    FileReader(std::string filename){
        this->filename = filename;
    }

    std::string read() {
        std::string line;
        std::ifstream file(this->filename);
        if(file.is_open()){
            std::string file_content;
            while(getline(file, line)){
                file_content += line;
            }
            return file_content;
        } 

        LooException *exception = new LooException("Unable to read file", -1);
        exception->throw_exception(0, true);
    }
};

class LooLang {
    public:
    std::string source;
    int position;
    int memory_cell;

    LooLang(std::string source_code){
        this->source = source_code;
        this->position = 0;
        this->memory_cell = 0;
    }

    void execute() {
        char character = this->current_character();
        while(character != ';'){
            if(character == '+'){
                this->memory_cell += 1;
            } else if(character == '-'){
                this->memory_cell -= 1;
            } else if(character == '#'){
                char output = this->memory_cell;
                std::cout << output;
            }
            this->position += 1;
            character = this->current_character();
        }
    }

    private:
    char current_character() {
        if(this->source.length() == this->position){
            return ';';
        } else {            
            return this->source[this->position];
        }
    }
};

std::string filename(int argc, const char *argv[]) {
    if(argc == 1){
        LooException *exception = new LooException("Expected a filename", -1);
        exception->throw_exception(0, true);
    } else {
        FileReader *reader = new FileReader(argv[1]);
        return reader->read();
    }
}

int main(int argc, char const *argv[]){
    std::string file = filename(argc, argv);
    LooLang *loo = new LooLang(file);
    loo->execute();
    return 0;
}
