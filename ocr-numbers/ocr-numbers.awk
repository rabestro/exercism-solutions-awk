BEGIN {
    RS = ""
    FS = "\n"
    DigitWidth = 3
    DigitHight = 4
}
NF % DigitHight {
    die("Number of input lines is not a multiple of four")
}
length($1) % DigitWidth {
    die("Number of input columns is not a multiple of three")
}
{
    print number()
}

function number(   col,row,result) {
    for (row = 1; row < NF; row += 4) {
        if (row > 1) result = result","
        for (col = 1; col < length($row); col += DigitWidth)
            result = result digit(row, col)
    }
    return result
}

function digit(row, col,   text) {
    text = cut(row, col) cut(row + 1, col) cut(row + 2, col)
    switch (text) {
        case " _ | ||_|": return 0
        case "     |  |": return 1
        case " _  _||_ ": return 2
        case " _  _| _|": return 3
        case "   |_|  |": return 4
        case " _ |_  _|": return 5
        case " _ |_ |_|": return 6
        case " _   |  |": return 7
        case " _ |_||_|": return 8
        case " _ |_| _|": return 9
        default: return "?"
    }
}

function cut(line, i) {return substr($line, i, DigitWidth)}
function die(message) {print message > "/dev/stderr"; exit 1}
