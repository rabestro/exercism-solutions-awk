BEGIN {
    FS=","
}
length($1) < $2 {die("span must be smaller than string length")}
$1 ~ /[^[:digit:]]/ {die("input must only contain digits")}
$2 < 0 {die("span must not be negative")}
!$2 {print 1; next}

{
    print largest_product()
}

function product(number,   digits,result,i) {
    split(number, digits, //)
    result = 1
    for (i in digits) result *= digits[i]
    return result
}
function largest_product(   i,number,mp) {
    for (i = length($1) - $2 + 1; i > 0; --i) {
        number = substr($1, i, $2)
        mp = max(mp, product(number))
    }
    return +mp
}
function die(message) {print message > "/dev/stderr"; exit 1}
function max(a, b) {return a > b ? a : b}
