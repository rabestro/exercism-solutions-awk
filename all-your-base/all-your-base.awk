# These variables are initialized on the command line (using '-v'):
# - ibase
# - obase

BEGIN {
    if (ibase < 2) die("invalid ibase")
    if (obase < 2) die("invalid obase")
}
{
    for (i = 1; i <= NF; ++i)
        if ($i >=0 && $i < ibase)
            number += $i * ibase ^ (NF - i)
        else die("invalid digit")

    for (NF = 0; number; number = int(number / obase))
        digit[NF++] = number % obase

    for (i = NF; i > 0; --i)
        $i = digit[NF - i]

    print
}

function die(message) {print message > "/dev/stderr"; exit 1}
