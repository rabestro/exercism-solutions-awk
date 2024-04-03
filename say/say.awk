BEGIN {
    Units[1e9] = " billion"
    Units[1e6] = " million"
    Units[1e3] = " thousand"

    split("one two three four five six seven eight nine ten eleven "\
        "twelve thirteen fourteen fifteen sixteen seventeen eighteen "\
        "nineteen twenty thirty forty fifty sixty seventy eighty ninety",\
    Numbers)
}
$0 < 0 || $0 >= 1e12 {
    print "input out of range"
    exit 1
}
!$0 {
    print "zero"; next
}
{
    print say($0)
}

function say(number,   i,out,part) {
    for (i = 1e9; i > 0; i = int(i/1e3)) {
        part = translate(int((number % (i*1000) / i)), Units[i])
        out = out (out && part ? " " : "") part
    }
    return out
}
function translate(number, unit,   units) {
    if (number < 1) return ""
    if (number < 21) return Numbers[number] unit
    if (number < 100) {
        units = number % 10
        return Numbers[18 + int(number/10)] (units?"-"Numbers[units]:"") unit
    }
    units = translate(number % 100, "")
    return translate(int(number/100), " hundred") (units?" "units:"") unit
}
