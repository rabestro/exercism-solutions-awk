# These variables are initialized on the command line (using '-v'):
# - limit

{
    for (n = 1; n < limit; ++n)
        if (is_multiple(n)) sum += n
    print +sum
}

function is_multiple(number,   i) {
    for (i = NF; i > 0; --i)
        if ($i && number % $i == 0) return 1
}
