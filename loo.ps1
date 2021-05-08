$filename = $args[0]

<#
Print out the parameter passed
in along with the function
#>
function print($data){
    Write-Output $data
}


<#
The main language parser which parser
and executes the code based on the tokens
#>
function language($data){
    # the value incremented and decremented
    # based on the tokens
    [int]$character_value = 0
    for($index=0; $index -lt $data.Length; $index++){
        [string]$character = $data[$index]
        for($j=0; $j -lt $character.Length; $j++){
            [string]$char = $character[$j]
            if($char -eq "+"){
                $character_value++
            } elseif($char -eq "-"){
                $character_value--
            } elseif($char -eq "#"){
                [char]$out = $character_value
                Write-Output $out
            } elseif($char -eq ";"){
                exit 1
            } else {
                throw("Unexpected character: $char")
            }
        }
    }
}

<#
Check file existence and read
the file if the file exists
#>
function readFileContent($filename){
    if (Test-Path $filename -PathType leaf) {
        $file = Get-Item $filename
        if($file.Extension -eq ".loo"){
            $content = Get-Content $filename
            language($content)
        } else {
            $extension = $file.Extension
            throw("Unexpected file extension $extension, expected .loo")
        }
    } else {
        throw("File does not exist")
    }
}

function validate_filename($filename) {
    if($filename){
        readFileContent($filename)
    } else {
        throw("No filename provided")
    }
}

validate_filename($filename)
