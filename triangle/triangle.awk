# These variables are initialized on the command line (using '-v'):
# - type

{
    print triangle() && @type() ? "true" : "false"
}

function equilateral() {
    return $1 == $2 && $2 == $3
}

function isosceles() {
    return $1 == $2 || $1 == $3 || $2 == $3
}

function scalene() {
    return $1 != $2 && $1 != $3 && $2 != $3
}

function triangle() {
    return $1 < $2 + $3 && $2 < $1 + $3 && $3 < $1 + $2
}
