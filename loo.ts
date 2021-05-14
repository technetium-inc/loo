import {existsSync, readFileSync, statSync} from 'fs';
import {argv, stdout} from 'process';

type Characters = '+' | '-' | '#' | ';';

function execute(data: string) {
  const currentCharacter = (pos: number, source: string): string | null => {
    if (source.length == pos) {
      return null;
    } else {
      return source[pos];
    }
  };

  let position: number = 0;
  let ascii: number = 0;
  let character: string | null = currentCharacter(position, data);
  while (character != null) {
    if (character == '+') {
      ascii += 1;
    } else if (character == '-') {
      ascii -= 1;
    } else if (character == '#') {
      stdout.write(String.fromCharCode(ascii));
    } else if (character == ';') {
      return 0;
    }

    position += 1;
    character = currentCharacter(position, data);
  }
}

function content(args: Array<string>): string | null {
  if (args.length == 0) {
    return null;
  }

  const filename: string = arguments[0][0];
  try {
    const exists = existsSync(filename);
    if (!statSync(filename).isFile()) {
      console.error(`${filename} not a file`);
    }
  } catch (exception: any) {
    console.error(exception.message);
  }
  const data = readFileSync(filename).toString();
  return data;
}

const data: string | null = content(argv.slice(2));
if (data) {
  execute(data);
}
