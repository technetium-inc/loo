import os

// Capturing the filename from the command
// line arguments and throwing an error if
// the filename is not mentioned
// Return the file content if it exists
fn source(arguments []string) string {
	if arguments.len == 0 {
		eprintln("No filename mentioned")
	}

	filename := arguments[0]
	data := os.read_file(filename) or {
		panic("Error reading $filename")
		return ''
	}
	return data
}


// Execute the loo code
fn execute(data string) int {
	characters := data.split("")
	mut ascii_position := 0
	for position, character in characters {
		if character == "+"{
			ascii_position += 1
		} else if character == "-" {
			ascii_position -= 1
		} else if character == "#" {
			print(byte(ascii_position).ascii_str())
		} else if character == ";" {
			return 0
		}
	}
	return 0
}

fn main() {
	arguments := os.args[1..]
	source_code := source(arguments)
	execute(source_code)
}
