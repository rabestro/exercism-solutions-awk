BEGIN {
    FPAT = "[.*]"
    OFS = ""
}
{
    for (col = NF; col; --col)
        Field[NR, col] = $col == "*"
}
END {
    while (row++ < NR) {
        for (col = NF; col; --col)
            $col = print_cell(row, col)
        print
    }
}

function print_cell(row, col,   mines,i,x,y) {
    if (Field[row, col]) return "*"
    for (i = 0; i < 9; i++) {
        x = row + int(i / 3) - 1
        y = col + i % 3 - 1
        mines += Field[x, y]
    }
    return mines ? mines : "."
}