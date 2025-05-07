BEGIN {
    RS = "[^[:alnum:]']"
    ORS = FS = ""
}
{
    print toupper($1)
}
