use std::env;
use std::path::Path;
use std::fs;

struct LooInterpreter {
    file_content: String
}

fn to_ascii(i: &i32) -> String {
    match *i {
        x@0...127 => format!("{:?}", x as u8 as char),
        _ => "".into(),
    }
}

impl LooInterpreter {
    fn execute(&self) {
        let characters = self.file_content.chars();
        let mut ascii_number:i32 = 0;
        for character in characters {
            if character == '+' {
                ascii_number += 1;
            } else if character == '-' {
                if ascii_number > 0 {
                    ascii_number -= 1;
                } else {
                    panic!("Ascii number reached 0");
                }
            } else if character == '#' {
                print!("{}", to_ascii(&ascii_number).to_string());
            }
        }
    }
}

fn main() {
    let arguments:Vec<String> = env::args().collect();
    let filename:String = String::from(if arguments.len() > 1 { arguments[1].to_string() } else { "".to_string() });
    let file_exists:bool = Path::new(&filename).is_file();
    if !file_exists {
        panic!("File does not exist");
    } 
    let file_content = fs::read_to_string(&filename).expect("file not found");
    let interpreter:LooInterpreter = LooInterpreter{file_content:file_content};
    interpreter.execute();
}
