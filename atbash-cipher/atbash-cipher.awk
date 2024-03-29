# These variables are initialized on the command line (using '-v'):
# -direction

BEGIN {
    FPAT = "[[:alnum:]]"
    Plain = "abcdefghijklmnopqrstuvwxyz"
    Cipher = "zyxwvutsrqponmlkjihgfedcba"
}
{
    @direction()
}

function encode(   i,out,symbol) {
    for (i = 0; i < NF; out = out symbol) {
        out = out (i++ % 5 || i == 1 ? "" : " ")
        symbol = $i ~ /[[:digit:]]/ ? $i : substr(Cipher, index(Plain, tolower($i)), 1)
    }
    print out
}

function decode(   i,out,symbol) {
    for (i = 0; i++ < NF; out = out symbol) {
        symbol = $i ~ /[[:digit:]]/ ? $i : substr(Plain, index(Cipher, tolower($i)), 1)
    }
    print out
}
