BEGIN {
    GigaSecond = 1e9
    FS = "[-T:]"
}
NF == 3 {
    $4 = $5 = $6 = "00"
}
{
    epoch = mktime($1" "$2" "$3" "$4" "$5" "$6, 1)
    print strftime("%FT%T", epoch + GigaSecond, 1)
}
