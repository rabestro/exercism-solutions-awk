#!/usr/bin/env bats
load bats-extra

# encode

@test "encode yes" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f affine-cipher.awk <<< "encode|5|7|yes"
    assert_success
    assert_output "xbt"
}

@test "encode no" {
    run gawk -f affine-cipher.awk <<< "encode|15|18|no"
    assert_success
    assert_output "fu"
}

@test "encode OMG" {
    run gawk -f affine-cipher.awk <<< "encode|21|3|OMG"
    assert_success
    assert_output "lvz"
}

@test "encode O M G" {
    run gawk -f affine-cipher.awk <<< "encode|25|47|O M G"
    assert_success
    assert_output "hjp"
}

@test "encode mindblowingly" {
    run gawk -f affine-cipher.awk <<< "encode|11|15|mindblowingly"
    assert_success
    assert_output "rzcwa gnxzc dgt"
}

@test "encode numbers" {
    run gawk -f affine-cipher.awk <<< "encode|3|4|Testing,1 2 3, testing."
    assert_success
    assert_output "jqgjc rw123 jqgjc rw"
}

@test "encode deep thought" {
    run gawk -f affine-cipher.awk <<< "encode|5|17|Truth is fiction."
    assert_success
    assert_output "iynia fdqfb ifje"
}

@test "encode all the letters" {
    run gawk -f affine-cipher.awk <<< "encode|17|33|The quick brown fox jumps over the lazy dog."
    assert_success
    assert_output "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
}

@test "encode with a not coprime to m" {
    run gawk -f affine-cipher.awk <<< "encode|6|17|This is a test."
    assert_failure
    assert_output --partial "a and m must be coprime."
}

# decode

@test "decode exercism" {
    run gawk -f affine-cipher.awk <<< "decode|3|7|tytgn fjr"
    assert_success
    assert_output "exercism"
}

@test "decode a sentence" {
    run gawk -f affine-cipher.awk <<< "decode|19|16|qdwju nqcro muwhn odqun oppmd aunwd o"
    assert_success
    assert_output "anobstacleisoftenasteppingstone"
}

@test "decode numbers" {
    run gawk -f affine-cipher.awk <<< "decode|25|7|odpoz ub123 odpoz ub"
    assert_success
    assert_output "testing123testing"
}

@test "decode all the letters" {
    run gawk -f affine-cipher.awk <<< "decode|17|33|swxtj npvyk lruol iejdc blaxk swxmh qzglf"
    assert_success
    assert_output "thequickbrownfoxjumpsoverthelazydog"
}

@test "decode with no spaces in input" {
    run gawk -f affine-cipher.awk <<< "decode|17|33|swxtjnpvyklruoliejdcblaxkswxmhqzglf"
    assert_success
    assert_output "thequickbrownfoxjumpsoverthelazydog"
}

@test "decode with too many spaces" {
    run gawk -f affine-cipher.awk <<< "decode|15|16|vszzm    cly   yd cg    qdp"
    assert_success
    assert_output "jollygreengiant"
}

@test "decode with a not coprime to m" {
    run gawk -f affine-cipher.awk <<< "decode|13|5|Test"
    assert_failure
    assert_output --partial "a and m must be coprime."
}
