# These variables are initialized on the command line (using '-v'):
# - n

BEGIN {
    if (n < 1) {
        print "invalid input"
        exit 1
    }

    Primes[Size = 1] = 2
    Primes[++Size] = 3
    for(Candidate = 5; !(n in Primes); Candidate += 2)
        if (is_prime(Candidate))
            Primes[++Size] = Candidate

    print Primes[n]
}

function is_prime(number,   i) {
    for (i in Primes)
        if (number % Primes[i] == 0) return 0
    return 1
}
