import std.stdio;
import std.format;
import std.conv;
import core.stdc.stdlib : exit;
import std.string;
import std.file;

/*
The loo exception class to
create exception messafes 
when an error occurs
*/
class LooException {
	private string message;
	private string suggestion;
	private string file;
	private string line;

	/*
	The constructor for the looexception
	class

	message(str) - The error message
	suggestion(str) - Try again message
	file(str) - The file in which the error occured
	line(int) - The line number at which the error occured
	*/
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

/*
The main language class where
the code is executed
*/
class LooLang {
	private immutable string data;
	private int line_number;
	private int position;
	private int ascii;

	/**
	The constructor for the LooLang 

	data(readonly str) - The code
	line_number(int) - The current line number
	position(int) - the parser position
	*/
	this(string data){
		this.data = data;
		this.line_number = 1;
		this.position = 0;
	}

	/**
	Execute the script
	*/
	public void executeLooLanguage() {
		char character = this.current_character();
		// stop the code if the executor
		// finds a semicolon(;).
		while(character != ';'){
			// increment the ascii value
			// if the character is +
			if(character == '+'){
				this.ascii += 1;
			} else if(character == '-'){
				// decrement the ascii value
				// if the character is -
				this.ascii -= 1;
			} else if(character == '#'){
				// print the ascii value in character
				// form if the character is #
				write(cast(char) this.ascii);
			} else if(character == '\n'){
				// increment the line number
				// if the executor finds a newline
				// character
				this.line_number += 1;
			} else if(character == ';') {
				break;
			}
			this.position += 1;
			character = this.current_character();
		}
	}

	/**
	Get the current character
	*/
	private char current_character() {
		if(this.data.length == this.position){
			return ';';
		} else {
			return this.data[this.position];
		}
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
	LooLang loo = new LooLang(read_file(find_filename(args)));
	loo.executeLooLanguage();
}
