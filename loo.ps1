$filename = $args[0]

function print($data){
    Write-Output $data
}

function language($data){
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
