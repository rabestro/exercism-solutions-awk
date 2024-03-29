# These variables are initialized on the command line (using '-v'):
# - key

BEGIN {
    Word = toupper(key)
    split(Word, Letters, //)
}

isCandidate() && isAnagram()

function isCandidate() {
    return length($0) == length(Word) && toupper($0) != Word
}

function isAnagram(   candidate,i) {
    candidate = toupper($0)
    for (i in Letters) sub(Letters[i], "", candidate)
    return !candidate
}
