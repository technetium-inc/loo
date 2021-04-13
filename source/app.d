import std.stdio;
import std.file;
import std.array;
import std.string;

/**
The core loolang class
*/
class LooLang {
    private string source;

    /**
    The default constructor for
    the loo lang class
    */
    this(string source) {
        this.source = source;
    }

    public void execute() {
        
    }
}

/**
Read a file 
*/
string read(const string filename) {
    File file = File(filename, "r");
    string filedata = "";

    while(!file.eof()){
        filedata ~= chomp(file.readln());
    }
    file.close();

    return filedata;
}

/**
The loo exception
*/
class LooException : Exception {
	/**
	Excpetion constructor
	*/
    this(string msg, string file = __FILE__, size_t line = __LINE__) {
        super(msg, file, line);
    }
}

void main(string[] args) {
	if(args.length != 1){
        const string filename = args[1];
        string source = read(filename);
        writeln(source);
    } else {
        throw new LooException("Expected the filename");
    }
}
