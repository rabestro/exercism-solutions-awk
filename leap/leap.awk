{
    print isLeapYear($0) ? "true" : "false"
}

function isLeapYear(year) {
    return year % 400 == 0 || year % 4 == 0 && year % 100 > 0
}
