{
    gsub(/ /, "")
    len = length($0)
}
/^[0-9]{2,}$/ {
    sum = 0
    isEven = len % 2 == 0
    for (i = 1; i <= len; i++) {
        digit = substr($0, i, 1)
        if (isEven) {
            digit *= 2
            if (digit > 9) {
                digit -= 9
            }
        }
        sum += digit
        isEven = !isEven
    }
    print sum % 10 == 0 ? "true" : "false"
    next
}
{
    print "false"
}
