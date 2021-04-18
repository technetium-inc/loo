import std.stdio;
import std.format;
import std.conv;
import core.stdc.stdlib : exit;
import std.string;
import std.file;

class LooException {
	private string message;
	private string suggestion;
	private string file;
	private string line;

	this(string message, string suggestion, string file, int line){
		this.message = message;
		this.suggestion = suggestion;
		this.file = file == null ? "" : format("in %s", file);
		this.line = line == 0 ? "" : format("at %s", to!string(line));
	}

	public int throwException(int exit_status, bool fatal) {
		writeln(format("Error : %s", this.message));
		writeln(format("Try : %s", this.suggestion));
		writeln(format("%s %s", this.file, this.line));
		if(fatal) {
			exit(exit_status);
		}
		return exit_status;
	}
}

string read_file(string filename){
	string data = "";
	File file = File(filename, "r");
	while (!file.eof()) { 
	   data ~= chomp(file.readln()); 
	 }
	file.close();

	return data;
}

string find_filename(string[] arguments) {
	int length = cast(int) arguments.length;
	if(length == 1) {
		LooException exc = new LooException("Expected a flename", "try again", null, 0);
		exc.throwException(0, true);
		return "";
	}

	return arguments[1];
}

void main(string[] args) {
	string data = read_file(find_filename(args));
	writeln(data);
}
