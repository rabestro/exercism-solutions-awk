BEGIN {
    FS = "[^[:alnum:]']"
}
{
    acronym = ""
    for (; NF; --NF) {
        acronym = substr($NF, 1, 1) acronym
    }
    print toupper(acronym)
}
