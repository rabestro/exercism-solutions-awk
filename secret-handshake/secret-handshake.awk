BEGIN {
    OFS = ","
    Code[1] = "wink"
    Code[2] = "double blink"
    Code[4] = "close your eyes"
    Code[8] = "jump"
    Reversed = 16
}
{
    signal = $1; NF = 0
    PROCINFO["sorted_in"] = sortOrder(signal)
    for (code in Code)
        if (and(signal, code)) $(++NF) = Code[code]
    print
}

function sortOrder(signal) {
    return "@ind_num_" (and(signal, Reversed) ? "desc" : "asc")
}
