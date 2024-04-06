BEGIN {
    FPAT = "-?[[:digit:]]+|[[:lower:]]{4,}( by)?"
    Operands = @/plus|minus|multiplied by|divided by/
    Number = @/-?[[:digit:]]+/
}
!/^What is/ {
    die("unknown operation")
}
{
    for (i = 2; i <= NF; ++i) {
        operand = $i
        if (operand ~ Number) die("syntax error")
        if (operand !~ Operands) die("unknown operation")
        if (++i > NF || $i ~ Operands) die("syntax error")

        switch (operand) {
            case "plus": $1 += $i; break
            case "minus": $1 -= $i; break
            case "multiplied by": $1 *= $i; break
            case "divided by": $1 /= $i; break
        }
    }
    print $1 ~ Number ? $1 : die("syntax error")
}

function die(message) {print message > "/dev/stderr"; exit 1}
