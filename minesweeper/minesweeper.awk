BEGIN {
    FPAT="[.*]"
    OFS = ""
}
NR == 1 {
    Width = NF
}
{
    for (col = NF; col; --col)
        Field[NR, col] = $col == "*"
}
END {
    while (row++ < NR) {
        for (col = Width; col; --col)
            $col = print_cell(row, col)
        print
    }
}

function print_cell(row, col,   mines) {
    if (Field[row, col]) return "*"
    mines = Field[row - 1, col - 1] \
        + Field[row - 1, col] \
        + Field[row - 1, col + 1] \
        + Field[row, col - 1] \
        + Field[row, col + 1] \
        + Field[row + 1, col - 1] \
        + Field[row + 1, col] \
        + Field[row + 1, col + 1]
    return mines ? mines : "."
}