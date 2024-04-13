NR == 1 {
    split($0, DNA, //)
    FPAT = "."
    next
}
NR == 2 && NF != length(DNA) {
    print "strands must be of equal length"
    exit 1
}
NR == 2  {
    for (i = NF; i; --i) distance += DNA[i] != $i
    print +distance
}
