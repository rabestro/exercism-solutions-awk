# Variables declared on the command line
#       start
#       end

BEGIN {
    split("fly spider bird cat dog goat cow horse", Animal)
    Phrase[1] = "I don't know why she swallowed the fly. Perhaps she'll die."
    Phrase[2] = "It wriggled and jiggled and tickled inside her."
    Phrase[3] = "How absurd to swallow a bird!"
    Phrase[4] = "Imagine that, to swallow a cat!"
    Phrase[5] = "What a hog, to swallow a dog!"
    Phrase[6] = "Just opened her throat and swallowed a goat!"
    Phrase[7] = "I don't know how she swallowed a cow!"
    Phrase[8] = "She's dead, of course!"

    for (i = start; i <= end; ++i) {
        verse(i)
        print ""
    }
}

function verse(i) {
    print "I know an old lady who swallowed a", Animal[i] "."
    if (i > 1) print Phrase[i]
    if (i == 8) return
    while (i > 1)
        print "She swallowed the", Animal[i], "to catch the", Animal[--i] \
        (i == 2 ? " that wriggled and jiggled and tickled inside her." : ".")

    print Phrase[1]
}
