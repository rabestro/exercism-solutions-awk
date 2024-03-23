BEGIN {
    RS = "^$"
}
{
    yelling  = /[[:upper:]]/ && !/[[:lower:]]/
    question = /\?[[:space:]]*$/
    silence  = /^[[:space:]]*$/
}
yelling && question {
    say("Calm down, I know what I'm doing!")
}
yelling {
    say("Whoa, chill out!")
}
question {
    say("Sure.")
}
!silence {
    say("Whatever.")
}
ENDFILE {
    say("Fine. Be that way!")
}

function say(message) {print message; exit }
