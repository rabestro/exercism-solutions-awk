BEGIN {
    IGNORECASE = 1
    Alphabet = "abcdefghijklmnopqrstuvwxyz"
}
{
    print isPangram() ? "true" : "false"
}
function isPangram() {
    # The input sentence forms the character range as regular expression.
    # We add a space in case if input sentence is an empty string.
    return !length(gensub("[ "$0"]", "", "g", Alphabet))
}
