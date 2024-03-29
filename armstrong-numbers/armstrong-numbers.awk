# These variables are initialized on the command line (using '-v'):
# - num

BEGIN {
    print isArmstrong(num) ? "true" : "false"
}

function isArmstrong(number,   power,sum,i) {
    power = length(number)
    for (i = power; i > 0; --i)
        sum += substr(number, i, 1) ^ power
    return number == sum
}
