@include "assert"
# These variables are initialized on the command line (using '-v'):
# - action

BEGIN {
    assert(action ~ /(en|de)code/, "unknown action")

    MSB = 128  # 0b10000000 - most significant bit
}

action == "encode" {
    for (i = 1; i <= NF; ++i) $i = encode($i)
    print
}

action == "decode" {
    for (i = 1; i <= NF; ++i) {
        dec = strtonum("0x"$i)
        if (dec >= MSB) {
            number = number * MSB + dec - MSB
        } else {
            $(++k) = dec2hex(number * MSB + dec)
            number = 0
        }
    }
    NF = k
    assert(NF && !number, "incomplete byte sequence")
    print
}

function encode(number,   out,dec) {
    number = strtonum("0x"number)
    do {
        dec = out ? MSB : 0
        dec += number % MSB
        out = dec2hex(dec) (out ? " " out : "")
        number = int(number / MSB)
    } while(number)

    return out
}

function dec2hex(d) { return sprintf("%02X", d) }
