BEGIN {
    FPAT = "[][(){}]"
    Opposite["("] = ")"
    Opposite["["] = "]"
    Opposite["{"] = "}"
    OpenBracket = @/[[{(]/
}
{
    print isMatchingBrackets() ? "true" : "false"
}

function isMatchingBrackets(   i,stack,size) {
    for (i = 1; i <= NF; ++i)
        if ($i ~ OpenBracket)
            stack[++size] = $i
        else if ($i != Opposite[stack[size--]])
            return 0

    return !size
}
