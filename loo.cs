using System;
using System.Collections.Generic;
using System.IO;

class MainClass {
  public static void Main (string[] args) {
    ArgumentParser parser = new ArgumentParser(args);
		Tuple<string, Dictionary<string,string>> data = parser.createArgumentParser();
		Interpreter loo = new Interpreter(data.Item1);
  }

	private class Interpreter {
		private readonly string filename;

		public Interpreter(string filename){
			this.filename = filename;
		}

		private string getFileContent(){
			try {
				return IO.File.ReadAllText(this.filename);
			} catch(exception) {
				return null;
			}
		}
	}

	private class ArgumentParser{
		private readonly string[] arguments;
		private readonly int length;

		public ArgumentParser(string[] arguments){
			this.arguments = arguments;
			this.length = this.arguments.Length;
		}

		public Tuple<string, Dictionary<string, string>> createArgumentParser() {
			string command = null;
			Dictionary<string, string> parameters = new Dictionary<string, string>();
			for(int index=0; index<this.arguments.Length; index++){
				string current = this.arguments[index];
				if(index == 0) {
					command = current;
					continue;
				}
				string[] statements = current.Split("=");
				string key = statements[0];
				string value = "";
				if (statements.Length > 1){
					value = statements[1];
				}
				parameters[key] = value;
			}
			return new Tuple<string, Dictionary<string,string>>(
				command,
				parameters
			);
		}
	}
}
