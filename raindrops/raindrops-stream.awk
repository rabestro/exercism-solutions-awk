BEGIN {
    OFS = ""
}
{
    number = $1
}
number % 3 == 0 {
    $(NF++) = "Pling"
}
number % 5 == 0 {
    $(NF++) = "Plang"
}
number % 7 == 0 {
    $NF = "Plong"
}
1
