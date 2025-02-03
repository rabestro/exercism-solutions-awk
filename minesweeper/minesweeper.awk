BEGIN {
    FPAT = "[.*]"
    OFS = ""
}
{
    for (col = NF; col; --col)
        Field[NR, col] = $col == "*"
}
END {
    for (row = 1; row <= NR; ++row) {
        for (col = NF; col; --col)
            $col = count_mines(row, col)
        print
    }
}

function count_mines(row, col,   mines,i,x,y) {
    if (Field[row, col]) return "*"
    for (i = 0; i < 9; i++) {
        x = row + int(i / 3) - 1
        y = col + i % 3 - 1
        mines += Field[x, y]
    }
    return mines ? mines : "."
}