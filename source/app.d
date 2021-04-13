import std.stdio;

/**
The loo exception
*/
class LooException : Exception {
    this(string msg, string file = __FILE__, size_t line = __LINE__) {
        super(msg, file, line);
    }
}

/**
The loo argument parser
to parse arguments passed
in along with the command line
*/
class ArgumentParser {
	private string[] argumnents;
	private ulong length;

	/**
	The argument parser constructor
	*/
	this(string[] arguments) {
		this.argumnents = argumnents;
		this.length = this.argumnents.length;
	}

	public string parse_arguments() {
		return "";
	}
}

void main() {
	
}
