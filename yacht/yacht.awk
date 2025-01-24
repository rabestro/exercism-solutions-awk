BEGIN {
    FS = ","
    Number["ones"] = 1
    Number["twos"] = 2
    Number["threes"] = 3
    Number["fours"] = 4
    Number["fives"] = 5
    Number["sixes"] = 6
}
{
    Score = 0
    Category = $NF
    gsub(" ", "_", Category)
    delete DiceCounts
    while (--NF) DiceCounts[$NF]++
}
Category == "yacht" && length(DiceCounts) == 1 {
    Score = 50
}
Category ~ "ones|twos|threes|fours|fives|sixes" {
    side = Number[Category]
    Score = DiceCounts[side] ? side * DiceCounts[side] : 0
}
Category ~ "full|kind" {
    Score = @Category()
}
Category ~ "straight" && length(DiceCounts) == 5 {
    Score = DiceCounts[Category ~ "big" ? 1 : 6] ? 0 : 30
}
Category == "choice" {
    for (key in DiceCounts)
        Score += key * DiceCounts[key]
}
{
    print Score
}
function full_house(   score,key) {
    for (key in DiceCounts) {
        if (DiceCounts[key] < 2 || DiceCounts[key] > 3)
            return 0
        score += key * DiceCounts[key]
    }
    return score
}
function four_of_a_kind(   key) {
    for (key in DiceCounts)
        if (DiceCounts[key] > 3)
            return key * 4
    return 0
}