BEGIN {
    FPAT = "[0-9]"
    OFS = ""
}
/[[:alpha:]]/ {
    die("letters not permitted")
}
/[@:!]/ {
    die("punctuations not permitted")
}
NF < 10 {
    die("must not be fewer than 10 digits")
}
NF > 11 {
    die("must not be greater than 11 digits")
}
NF == 11 && $1 != "1" {
    die("11 digits must start with 1")
}
NF == 11 && $1 == 1 {
    $0 = gensub(/1/, "", 1)
}
$1 == 0 {
    die("area code cannot start with zero")
}
$1 == 1 {
    die("area code cannot start with one")
}
$4 == 0 {
    die("exchange code cannot start with zero")
}
$4 == 1 {
    die("exchange code cannot start with one")
}

$1 {$1 = $1} 1

function die(message) {print message > "/dev/stderr"; exit 1}
