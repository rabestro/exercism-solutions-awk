BEGIN {
    FS = ""
}
{
    for (i = 1; i <= NF; ++i) {
        bit = lshift(1, i - 1)
        if ($i ~ /[-+]/) H[NR] = or(H[NR], bit)
        if ($i ~ /[|+]/) V[NR] = or(V[NR], bit)
    }
}
END {
    Height = NR
    Width = NF

    for (rowA = 1; rowA < Height; ++rowA) {
        for (colA = 1; colA < Width; ++colA) {
            total += cornerA(rowA, colA)
        }
    }
    print +total
}

function isPlus(row, col) {
    return and(H[row], V[row], lshift(1, col - 1))
}

function isVerticalLine(row, col) {
    return row <= Height && and(V[row], lshift(1, col - 1))
}

function isHorizontalLine(row, col) {
    return col <= Width && and(H[row], lshift(1, col - 1))
}

function cornerA(rowA, colA,   total,colB) {
    if (!isPlus(rowA, colA)) return 0
    for (colB = colA + 1; isHorizontalLine(rowA, colB); ++colB) {
        total += cornerB(rowA, colA, colB)
    }
    return +total
}

function cornerB(rowA, colA, colB,   rowC,total) {
    if (!isPlus(rowA, colB)) return 0
    for (rowC = rowA + 1; isVerticalLine(rowC, colA) && isVerticalLine(rowC, colB); ++rowC) {
        total += cornerC(colA, colB, rowC)
    }
    return +total
}

function cornerC(colA, colB, rowC,   i) {
    if (!isPlus(rowC, colB)) return 0
    if (!isPlus(rowC, colA)) return 0
    for (i = colB - 1; i > colA; --i) {
        if (!isHorizontalLine(rowC, i)) return 0
    }
    return 1
}
