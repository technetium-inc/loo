import os

struct Position {
	data string
	mut:
	position int
}

fn (mut position Position) increment(increment_by int) int {
	position.position += increment_by
	return position.position
}

fn (position Position) current_character() string {
	if position.position == position.data.len {
		return ';'
	} else {
		return position.data[position.position].str()
	}
}

fn create_byte_array(data string) []byte {
	mut byte_array := []byte{}
	for index := 0; index < data.len; index++ {
		byte_array << data[index]
	}
	return byte_array
}

fn execute(data string) {
	data_array := data.split('')
	mut ascii := 0
	for current_character in data_array {
		if current_character == '+' {
			ascii += 1
		} else if current_character == '-' {
			ascii -= 1
		} else if current_character == ';' {
			break
		} else if current_character == '#' {
			print(byte(ascii).ascii_str())
		}
	}
}

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


fn main() {
	arguments := os.args[1..]
	source_code := source(arguments)
	execute(source_code)
}
