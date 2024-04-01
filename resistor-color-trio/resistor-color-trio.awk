BEGIN {
    Colors["black"] = 0
    Colors["brown"] = 1
    Colors["red"] = 2
    Colors["orange"] = 3
    Colors["yellow"] = 4
    Colors["green"] = 5
    Colors["blue"] = 6
    Colors["violet"] = 7
    Colors["grey"] = 8
    Colors["white"] = 9

    Suffix["000000000"] = "giga"
    Suffix["000000"] = "mega"
    Suffix["000"] = "kilo"

}
$1 in Colors && $2 in Colors && $3 in Colors {
    resistance = +(Colors[$1] Colors[$2]) * 10 ^ Colors[$3]

    for (zeros in Suffix)
        if (resistance ~ zeros) {
            resistance /= 10 ^ length(zeros)
            suffix = Suffix[zeros]
        }

    print resistance, suffix"ohms"
    next
}
{
    print "invalid color"
    exit 1
}
