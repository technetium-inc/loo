package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"
)

func createInterpreter(filename string) bool {
	body, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Fatalf("Unable to read file %v", err)
		return false
	}

	var current_ascii_index int = 0
	for index := 0; index < len(body); index++ {
		var character byte = body[index]
		switch character {
		case '+':
			current_ascii_index += 1
		case '-':
			current_ascii_index -= 1
		case ';':
			return false
		case '#':
			fmt.Print(string(current_ascii_index))
		}
	}

	return true
}

func performCommand(command string) {
	if command == "help" {
		fmt.Println("Helping...")
	} else {
		_ = createInterpreter(command)
	}
}

func parseArguments(arguments []string) (string, map[string]string) {
	command, parameters := "", make(map[string]string)
	for index, argument := range arguments {
		if index == 0 {
			command = argument
			continue
		}
		isValidArgument := strings.HasPrefix(argument, "--")
		if !isValidArgument {
			fmt.Println("Invalid argument:" + argument)
			os.Exit(1)
		}
		slices := strings.Split(argument, "=")
		key, value := slices[0], strings.Join(slices[1:], "=")
		parameters[key] = value
	}
	return command, parameters
}

func main() {
	arguments := os.Args[1:]
	command, _ := parseArguments(arguments)
	performCommand(command)
	fmt.Println()
}
