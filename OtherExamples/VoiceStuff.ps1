#$msg = "Do you feel in charge?"
#$msg = "hey, real cops"
#$msg = "Now is not the time for fear, that comes later."
#$msg = "You should reboot everything"
$msg = "I'm sorry, Dave. I'm afraid I can't do that."

$voice = new-object -com SAPI.SpVoice;
$voice.Voice = "David"  #defaults to your system default
$Voice.Speak( $msg, 1 )