# These variables are initialized on the command line (using '-v'):
# - size

BEGIN {
    delete Matrix
    create_matrix()
    print_matrix()
}
function create_matrix(level, max_level) {
    max_level = int((size + 1) / 2)
    for (level = 1; level <= max_level; ++level)
        square(level)
}
function print_matrix() {
    for (row = 1; row <= size; ++row) {
        for (col = 1; col <= size; ++col) {
            $col = Matrix[row, col]
        }
        print
    }
}
function square(level, len) {
    len = size - level * 2 + 1
    if (len > 0) {
        line(level, level, 0, 1, len)
        line(level, level + len, 1, 0, len)
        line(level + len, level + len, 0, -1, len)
        line(level + len, level, -1, 0, len)
    } else
        Matrix[level, level] = ++Number
}
function line(x, y, dx, dy, len) {
    while(len--) {
        Matrix[x, y] = ++Number
        x += dx; y += dy
    }
}