# These variables are initialized on the command line (using '-v'):
# - num

BEGIN {
    print isAmstrong(num) ? "true" : "false"
}

function isAmstrong(number,   power,sum,i) {
    power = length(number)
    for (i = power; i > 0; --i)
        sum += substr(number, i, 1) ^ power
    return number == sum
}
