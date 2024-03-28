BEGIN {
    OFS = FS = ","
    Items["eggs"] = 1
    Items["peanuts"] = 2
    Items["shellfish"] = 4
    Items["strawberries"] = 8
    Items["tomatoes"] = 16
    Items["chocolate"] = 32
    Items["pollen"] = 64
    Items["cats"] = 128
}
{
    score = $1 % 256
}
/allergic_to/ {
    print isAllegric(score, Items[$3]) ? "true" : "false"
}
/list/ {
    NF = 0
    for (i = 1; i <= 128; i *= 2)
        if (isAllegric(score, i))
            $(++NF) = itemName(i)
    print
}

function isAllegric(score, item) {
    return and(score, item) == item
}

function itemName(score,   name) {
    for (name in Items)
        if (Items[name] == score)
            return name
}
