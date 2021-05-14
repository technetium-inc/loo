"use strict";
exports.__esModule = true;
var fs_1 = require("fs");
var process_1 = require("process");
function execute(data) {
    var currentCharacter = function (pos, source) {
        if (source.length == pos) {
            return null;
        }
        else {
            return source[pos];
        }
    };
    var position = 0;
    var ascii = 0;
    var character = currentCharacter(position, data);
    while (character != null) {
        if (character == '+') {
            ascii += 1;
        }
        else if (character == '-') {
            ascii -= 1;
        }
        else if (character == '#') {
            process_1.stdout.write(String.fromCharCode(ascii));
        }
        else if (character == ';') {
            return 0;
        }
        position += 1;
        character = currentCharacter(position, data);
    }
}
function content(args) {
    if (args.length == 0) {
        return null;
    }
    var filename = arguments[0][0];
    try {
        var exists = fs_1.existsSync(filename);
        if (!fs_1.statSync(filename).isFile()) {
            console.error(filename + " not a file");
        }
    }
    catch (exception) {
        console.error(exception.message);
    }
    var data = fs_1.readFileSync(filename).toString();
    return data;
}
var data = content(process_1.argv.slice(2));
if (data) {
    execute(data);
}
