# These variables are initialized on the command line (using '-v'):
# - x
# - y
# - dir

BEGIN {
    x = +x; y = +y
    dir = dir ? dir : "north"
    if (dir !~ /north|east|south|west/) die("invalid direction")
}
/R/ {
    if (dir == "north") dir = "east"
    else if (dir == "east") dir = "south"
    else if (dir == "south") dir = "west"
    else dir = "north"
}
/L/ {
    if (dir == "north") dir = "west"
    else if (dir == "west") dir = "south"
    else if (dir == "south") dir = "east"
    else  dir = "north"
}
/A/ {
    switch (dir) {
        case "north": y++; next
        case "east": x++; next
        case "south": y--; next
        case "west": x--; next
    }
}
/[^ALR]/ {
    die("invalid instruction")
}

END {
    if (dir) print x, y, dir
}

function die(message) {
    print message > "/dev/stderr"
    x = y = dir = ""
    exit 1
}
