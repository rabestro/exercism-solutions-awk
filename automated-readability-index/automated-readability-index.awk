BEGIN {
    CONVFMT = "%.0f"
    OFMT = "%.2f"
    RS = @/[!?.]+[[:space:]]+/
    split("5-6 6-7 7-8 8-9 9-10 10-11 11-12 12-13 13-14 14-15 15-16 16-17 17-18 18-22", Ages)
}

NR == 1 {
    print "The text is:"
}
{
    gsub(/[[:space:]]+/, " ")
    $0 = gensub(/[[:space:]]+$/, "", 1, $0 RT)
}
NR < 4 {
    print gensub(/^(.{50}).+/, "\\1...", 1, $0)
}
NR == 4 {
    print "..."
}
{
    Words += NF
    for (i = 1; i <= NF; ++i) {
        Characters += length($i)
    }
}

END {
    Sentences = NR
    Score = 4.71 * Characters / Words + 0.5 * Words / Sentences - 21.43
    if (Score > 14) ARI = 14
    else ARI = ""Score

    print_stats()
}

function print_stats() {
    print ""
    print "Words:", Words
    print "Sentences:", Sentences
    print "Characters:", Characters
    print "Score:", Score
    print "This text should be understood by", Ages[ARI], "year-olds."
}
