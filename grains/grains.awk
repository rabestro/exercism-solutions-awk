/total/ {
    print 2^64 - 1; next
}

in_range() {
    print 2 ^ ($1-1); next
}

{
    print "square must be between 1 and 64"; exit 1
}

function in_range() {
    return $0 > 0 && $0 < 65
}
