BEGIN {
    Score["[AEIOULNRST]"] = 1
    Score["[DG]"] = 2
    Score["[BCMP]"] = 3
    Score["[FHVWY]"] = 4
    Score["[K]"] = 5
    Score["[JX]"] = 8
    Score["[QZ]"] = 10
}
{
    printf("%s,", $0 = toupper($0))
    for (range in Score) score += gsub(range, "") * Score[range]
    print score
}
