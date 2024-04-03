# These variables are initialized on the command line (using '-v'):
# - len

BEGIN {
    FPAT = "[[:digit:]]+|."
}
{
    @type()
}
function encode(   i,previous,count,out) {
    for (i = 0; i++ <= NF; ++count)
        if (previous != $i) {
            out = out (count > 1 ? count : "") previous
            previous = $i
            count = 0
        }
    print out
}

function decode(   out,i,n) {
    for (i = 1; i <= NF; ++i)
        for (n = +$i ? $(i++) : 1; n > 0; --n)
            out = out $i
    print out
}
