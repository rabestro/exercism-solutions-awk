BEGIN {
    FS = "[^[:alnum:]']"
    OFS = ""
}
{
    for (i = 1; i <= NF; ++i) {
        $i = toupper(substr($i, 1, 1))
    }
    print
}
