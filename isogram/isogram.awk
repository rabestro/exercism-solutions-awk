BEGIN {
    FPAT = "[[:alpha:]]"
}
{
    delete Letters
    for (i = NF; i; --i) {
        letter = tolower($i)
        if (Letters[letter]) {
            print "false"
            next
        }
        Letters[letter] = 1
    }
    print "true"
}
