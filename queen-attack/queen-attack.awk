isValid() {
    print canAttack() ? "true" : "false"; next
}
{
    print "invalid"; exit 1
}

function isValid() {
    return /^([0-7] ){3}[0-7]/ && ($1 != $3 || $2 != $4)
}
function canAttack() {
    return $1 == $3 || $2 == $4 || abs($1 - $3) == abs($2 - $4)
}
function abs(v) {
    return v < 0 ? -v : v
}
