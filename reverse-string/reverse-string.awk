BEGIN {FS=""}
{
    print reverse()
}

function reverse(   i,result) {
    for (i = NF; i ; --i) {
        result = result $i
    }
    return result
}
