# These variables are initialized on the command line (using '-v'):
# - verse
# - start
# - stop

BEGIN {
    if (verse != "") start = stop = verse
    for (Bottles = start; Bottles >= stop;) {
        print on_the_wall(Bottles)
        print take_it(--Bottles)
    }
}

function on_the_wall(number) {
    if (number >= 2) return number" bottles of beer on the wall, "number" bottles of beer."
    if (number == 1) return "1 bottle of beer on the wall, 1 bottle of beer."
    if (number == 0) return "No more bottles of beer on the wall, no more bottles of beer."
}

function take_it(number) {
    if (number >= 2) return "Take one down and pass it around, "number" bottles of beer on the wall."
    if (number == 1) return "Take one down and pass it around, 1 bottle of beer on the wall."
    if (number == 0) return "Take it down and pass it around, no more bottles of beer on the wall."
    return "Go to the store and buy some more, 99 bottles of beer on the wall."
}
