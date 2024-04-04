BEGIN {
    OFS = ","
    UNMARKED = 1
    MARKED = 0
}
{
    Limit = $1
}
Limit > 1 {
    create_numbers()
    sieve_numbers()
    print
}

function create_numbers(   i) {
    delete Numbers
    for (i = 2; i <= Limit; ++i) {
        Numbers[i] = UNMARKED
    }
}

function sieve_numbers(   i) {
    NF = 0
    for (i = 2; i <= Limit; i++) {
        if (Numbers[i] == UNMARKED) {
            ++NF; $NF = i
            mark_numbers(i)
        }
    }
}

function mark_numbers(prime,   i) {
    for (i = 2 * prime; i <= Limit; i += prime) {
        Numbers[i] = MARKED
    }
}
