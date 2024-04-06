#!/usr/bin/env bats
load bats-extra

#
# *** Input and Output numbers are expressed in hexadecimal.
#

# Encode a series of integers, producing a series of bytes.

@test "encode zero" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f variable-length-quantity.awk -v action=encode <<< "00"
    assert_success
    assert_output "00"
}

@test "encode arbitrary single byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "40"
    assert_success
    assert_output "40"
}

@test "encode largest single byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "7F"
    assert_success
    assert_output "7F"
}

@test "encode smallest double byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "80"
    assert_success
    assert_output "81 00"
}

@test "encode arbitrary double byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "2000"
    assert_success
    assert_output "C0 00"
}

@test "encode largest double byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "3FFF"
    assert_success
    assert_output "FF 7F"
}

@test "encode smallest triple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "4000"
    assert_success
    assert_output "81 80 00"
}

@test "encode arbitrary triple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "100000"
    assert_success
    assert_output "C0 80 00"
}

@test "encode largest triple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "1FFFFF"
    assert_success
    assert_output "FF FF 7F"
}

@test "encode smallest quadruple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "200000"
    assert_success
    assert_output "81 80 80 00"
}

@test "encode arbitrary quadruple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "8000000"
    assert_success
    assert_output "C0 80 80 00"
}

@test "encode largest quadruple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "FFFFFFF"
    assert_success
    assert_output "FF FF FF 7F"
}

@test "encode smallest quintuple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "10000000"
    assert_success
    assert_output "81 80 80 80 00"
}

@test "encode arbitrary quintuple byte" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "FF000000"
    assert_success
    assert_output "8F F8 80 80 00"
}

@test "encode maximum 32-bit integer input" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "FFFFFFFF"
    assert_success
    assert_output "8F FF FF FF 7F"
}

@test "encode two single-byte values" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "40 7F"
    assert_success
    assert_output "40 7F"
}

@test "encode two multi-byte values" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "4000 123456"
    assert_success
    assert_output "81 80 00 C8 E8 56"
}

@test "encode many multi-byte values" {
    run gawk -f variable-length-quantity.awk -v action=encode <<< "2000 123456 FFFFFFF 00 3FFF 4000"
    assert_success
    assert_output "C0 00 C8 E8 56 FF FF FF 7F 00 FF 7F 81 80 00"
}

# Decode a series of bytes, producing a series of integers.

@test "decode one byte" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "7F"
    assert_success
    assert_output "7F"
}

@test "decode two bytes" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "C0 00"
    assert_success
    assert_output "2000"
}

@test "decode three bytes" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "FF FF 7F"
    assert_success
    assert_output "1FFFFF"
}

@test "decode four bytes" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "81 80 80 00"
    assert_success
    assert_output "200000"
}

@test "decode maximum 32-bit integer" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "8F FF FF FF 7F"
    assert_success
    assert_output "FFFFFFFF"
}

@test "decode multiple values" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "C0 00 C8 E8 56 FF FF FF 7F 00 FF 7F 81 80 00"
    assert_success
    assert_output "2000 123456 FFFFFFF 00 3FFF 4000"
}

# Some error conditions

@test "decode incomplete sequence causes error" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "FF"
    assert_failure
    assert_output --partial "incomplete byte sequence"
}

@test "decode incomplete sequence causes error, even if value is zero" {
    run gawk -f variable-length-quantity.awk -v action=decode <<< "80"
    assert_failure
    assert_output --partial "incomplete byte sequence"
}

@test "invalid subcommand" {
    run gawk -f variable-length-quantity.awk -v action=hello <<< "80"
    assert_failure
    assert_output --partial "unknown action"
}
