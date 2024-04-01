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
}
$1 in Colors && $2 in Colors {
    print +(Colors[$1] Colors[$2]); next
}
{
    print "invalid color"; exit 1
}
