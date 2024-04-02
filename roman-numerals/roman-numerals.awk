BEGIN {
    PROCINFO["sorted_in"] = "@ind_num_asc"

    NumeralCount = split("M CM D CD C XC L XL X IX V IV I", RomanNumerals)
    split("1000 900 500 400 100 90 50 40 10 9 5 4 1", ArabicNumerals)
}
{
    print toRomanNumeral($0)
}

function toRomanNumeral(number, i, roman) {
    for (i = 1; i <= NumeralCount; ++i) {
        while (ArabicNumerals[i] <= number) {
            number -= ArabicNumerals[i]
            roman = roman RomanNumerals[i]
        }
    }
    return roman
}
