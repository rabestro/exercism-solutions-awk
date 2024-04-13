# These variables are initialized on the command line (using '-v'):
# - flags
# - pattern

BEGIN {
    IGNORECASE = flags ~ /i/
    if (flags ~ /x/) pattern = "^"pattern"$"
}

($0 ~ pattern) != (flags ~ /v/) {
    Success = 1
    if (flags ~ /l/) {
        print FILENAME
        nextfile
    }
    if (ARGC > 2) printf "%s:", FILENAME
    if (flags ~ /n/) printf "%s:", FNR
    print
}

END {
    if (!Success) exit 1
}
