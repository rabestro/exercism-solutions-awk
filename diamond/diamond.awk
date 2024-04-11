#!/usr/bin/env gawk -f
@load "ordchr"
BEGIN {
    OFS = ""
    A = ord("A")
}
{
    half = ord($0) - A + 1
    NF = 2 * half - 1

    for (row = 0; row < NF; ++row) {
        for (i = 1; i <= NF; ++i) $i = " "

        if (row < half) {
            symbol = A + row
            a = half - row
            b = half + row
        } else {
            symbol = A + NF - row - 1
            a = half + row - NF + 1
            b = half - row + NF - 1
        }
        $a = $b = chr(symbol)
        print
    }
}
