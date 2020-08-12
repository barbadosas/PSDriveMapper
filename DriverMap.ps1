$wshell = New-Object -ComObject Wscript.Shell -ErrorAction SilentlyContinue
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$title = 'Map C Disc to available free drive'
$pc   = 'Script will map random available drive letter with selected machines c$ drive. 

Enter machine name which c$ needs to be mapped'

$text = [Microsoft.VisualBasic.Interaction]::InputBox($pc, $title)
$username = ''
$ran = ls function:[d-z]: -n | ?{ !(test-path $_) } | random

if (test-connection -computername $text -count 1 -ErrorAction SilentlyContinue){

    $Drive = New-PSDrive -PSProvider FileSystem -Name $ran.Substring(0,1) -root "\\$text\c$" -Persist -Credential $username -ErrorAction SilentlyContinue
 
    $prompt = $wshell.Popup("Task has been completed!" ,5,"Done!",48)
    }

else{
    $prompt = $wshell.Popup("Machine is offline or Machine name is not correct",5,"Task failed",48)
    }
    
