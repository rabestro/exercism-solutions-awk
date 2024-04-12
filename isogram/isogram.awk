BEGIN {
    FPAT = "[[:alpha:]]"
}
{
    previous_letters = ""
    for (i = NF; i; --i) {
        letter = tolower($i)
        if (index(previous_letters, letter)) {
            print "false"
            next
        }
        previous_letters = previous_letters letter
    }
    print "true"
}
