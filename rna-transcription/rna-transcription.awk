BEGIN {
    OFS = FS = ""
    T["G"] = "C"
    T["C"] = "G"
    T["T"] = "A"
    T["A"] = "U"
}
/[^GCTA]/ {
    print "Invalid nucleotide detected."; exit 1
}
{
    for (i = 0; i++ < NF; $i = T[$i]);
    print
}
