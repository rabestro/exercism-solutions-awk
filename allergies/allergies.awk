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
    print isAlegric(score, Items[$3]) ? "true" : "false"
}
/list/ {
    NF = 0
    for (i = 1; i <= 128; i *= 2)
        if (isAlegric(score, i))
            $(++NF) = itemName(i)
    print
}

function isAlegric(score, item,   i) {
    for (i = 128; i > item; i /= 2)
        if (score >= i) score -= i
    return score >= item
}

function itemName(score,   name) {
    for (name in Items)
        if (Items[name] == score)
            return name
}
