#$msg = "booooooooom"
$msg = "hey, real cops"
$voice = new-object -com SAPI.SpVoice;
$Voice.Speak( $msg, 1 )