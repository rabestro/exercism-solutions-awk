BEGIN {FS = ","}

/teenth/ {print find_date(13)}
/first/ {print find_date(1)}
/second/ {print find_date(8)}
/third/ {print find_date(15)}
/fourth/ {print find_date(22)}
/last/ {print find_date(last_day($1, $2) - 6)}

function weekday(day) {
    return strftime("%A", mktime(sprintf("%4d %02d %02d 0 0 0", $1, $2, day)))
}
function find_date(startDay,    day) {
    for (day = startDay + 6; day >= startDay; --day)
        if (weekday(day) == $4)
            return sprintf("%4d-%02d-%02d", $1, $2, day)
}
function last_day(year, month) {
    if (++month == 13) {++year; month = 1}
    return strftime("%d", mktime(year " " month " 01 0 0 0") - 1)
}
