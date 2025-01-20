# These variables are initialized on the command line (using '-v'):
# - value

BEGIN {
    FS=","
}
{
    print binary_search(1, NF)
}

function binary_search(low, high,   mid) {
    if (low > high) return -1
    mid = int((low + high) / 2)
    if ($mid > value) return binary_search(low, mid - 1)
    if ($mid < value) return binary_search(mid + 1, high)
    return mid
}