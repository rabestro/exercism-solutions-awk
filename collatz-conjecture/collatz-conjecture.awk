$1 > 0 {
    print Collatz_Conjecture($1)
}
$1 < 1 {
    die("Error: Only positive numbers are allowed")
}

function Collatz_Conjecture(number,   step) {
    step = 0
    while (number > 1) {
        ++step
        number = number % 2 ? 3 * number + 1 : number / 2
    }
    return step
}

function die(message) {print message > "/dev/stderr"; exit 1}
