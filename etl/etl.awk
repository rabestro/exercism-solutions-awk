BEGIN {
    FPAT = "[[:digit:]]{1,2}|[[:alpha:]]"
    OFS = ","
}
{
    for (i = 2; i <= NF; ++i)
        Score[tolower($i)] = $1
}
END {
    PROCINFO["sorted_in"] = "@ind_str_asc"
    for (letter in Score)
        print letter, Score[letter]
}
