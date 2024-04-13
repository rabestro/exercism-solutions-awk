BEGIN {
    PROCINFO["sorted_in"] = "@val_num_desc"
}

/[[:digit:]]+/ {
    Score[++Size] = $1
    if ($1 > MaxScore) MaxScore = $1
}
/list/ {
    for (i = 1; i <= Size; ++i) print Score[i]
}
/latest/ {
    print Score[Size]
}
/personalBest/ {
    top(1)
}
/personalTopThree/ {
    top(3)
}

function top(n,   i) {
    for (i in Score)
        if (!n--) break
        else print Score[i]
}
