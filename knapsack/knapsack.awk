BEGIN {
    FS = "[:,]"
}
/limit/ {
    Capacity = $2
}
/weight/ {
    ItemsCount++
    Weight[ItemsCount] = $2
    Value[ItemsCount] = $4
}
END {
    print maxValue(Capacity)
}

function maxValue(capacity, start,   value,i,weight,max) {
    for (i = start; i++ < ItemsCount; max = value > max ? value : max) {
        weight = capacity - Weight[i]
        value = weight < 0 ? 0 : Value[i] + maxValue(weight, i)
    }
    return +max
}
