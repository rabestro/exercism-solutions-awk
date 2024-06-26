BEGIN {
    FS = ","
}
{
    request = $1
    print @request($2)
}
function square_of_sum(n) {
    return (n * (n + 1) / 2) ^ 2
}
function sum_of_squares(n) {
    return n * (n + 1) * (2 * n + 1) / 6
}
function difference(n) {
    return square_of_sum(n) - sum_of_squares(n)
}
