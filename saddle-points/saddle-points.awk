NR == 1 {
    for (i = 1; i <= NF; i++) ColsMinimum[i] = $i
}
{
    RowsMaximum[NR] = $1
    for (i = 2; i <= NF; i++) if ($i > RowsMaximum[NR]) RowsMaximum[NR] = $i
    for (i = 1; i <= NF; i++) if ($i < ColsMinimum[i]) ColsMinimum[i] = $i
}
END {
    for (row = 1; row <= NR; row++) for (col = 1; col <= NF; col++)
        if (RowsMaximum[row] == ColsMinimum[col]) print row, col
}