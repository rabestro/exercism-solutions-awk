#!/usr/bin/env bats
load bats-extra

# local version: 2.3.0.0

@test 'single bit to one decimal' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f all-your-base.awk -v ibase=2 -v obase=10 <<< "1"
    assert_success
    assert_output "1"
}

@test 'binary to single decimal' {
    run gawk -f all-your-base.awk -v ibase=2 -v obase=10 <<< "1 0 1"
    assert_success
    assert_output "5"
}

@test 'single decimal to binary' {
    run gawk -f all-your-base.awk -v ibase=10 -v obase=2 <<< "5"
    assert_success
    assert_output "1 0 1"
}

@test 'binary to multiple decimal' {
    run gawk -f all-your-base.awk -v ibase=2 -v obase=10 <<< "1 0 1 0 1 0"
    assert_success
    assert_output "4 2"
}

@test 'decimal to binary' {
    run gawk -f all-your-base.awk -v ibase=10 -v obase=2 <<< "4 2"
    assert_success
    assert_output "1 0 1 0 1 0"
}

@test 'trinary to hexadecimal' {
    run gawk -f all-your-base.awk -v ibase=3 -v obase=16 <<< "1 1 2 0"
    assert_success
    assert_output "2 10"
}

@test 'hexadecimal to trinary' {
    run gawk -f all-your-base.awk -v ibase=16 -v obase=3 <<< "2 10"
    assert_success
    assert_output "1 1 2 0"
}

@test '15 bit integer' {
    run gawk -f all-your-base.awk -v ibase=97 -v obase=73 <<< "3 46 60"
    assert_success
    assert_output "6 10 45"
}

@test 'empty list' {
    run gawk -f all-your-base.awk -v ibase=2 -v obase=10 <<< ""
    assert_success
    assert_output ""
}

@test 'single zero' {
    run gawk -f all-your-base.awk -v ibase=10 -v obase=2 <<< "0"
    assert_success
    assert_output ""
}

@test 'multiple zeroes' {
    run gawk -f all-your-base.awk -v ibase=10 -v obase=2 <<< "0 0 0"
    assert_success
    assert_output ""
}

@test 'leading zeros' {
    run gawk -f all-your-base.awk -v ibase=7 -v obase=10 <<< "0 6 0"
    assert_success
    assert_output "4 2"
}

@test 'input base is one' {
    run gawk -f all-your-base.awk -v ibase=1 -v obase=10 <<< "0"
    assert_failure
    assert_output    # there is _some_ output
}

@test 'input base is zero' {
    run gawk -f all-your-base.awk -v ibase=0 -v obase=10 <<< ""
    assert_failure
    assert_output    # there is _some_ output
}

@test 'input base is negative' {
    run gawk -f all-your-base.awk -v ibase=-2 -v obase=10 <<< "1"
    assert_failure
    assert_output    # there is _some_ output
}

@test 'negative digit' {
    run gawk -f all-your-base.awk -v ibase=2 -v obase=10 <<< "1 -1 1 0 1 0"
    assert_failure
    assert_output    # there is _some_ output
}

@test 'invalid positive digit' {
    run gawk -f all-your-base.awk -v ibase=2 -v obase=10 <<< "1 2 1 0 1 0"
    assert_failure
    assert_output    # there is _some_ output
}

@test 'output base is one' {
    run gawk -f all-your-base.awk -v ibase=2 1 <<< "1 0 1 0 1 -v obase=0"
    assert_failure
    assert_output    # there is _some_ output
}

@test 'output base is zero' {
    run gawk -f all-your-base.awk -v ibase=10 -v obase 0 <<<="7"
    assert_failure
    assert_output    # there is _some_ output
}

@test 'output base is negative' {
    run gawk -f all-your-base.awk -v ibase=2 -v obase=-7 <<< "1"
    assert_failure
    assert_output    # there is _some_ output
}

@test 'both bases are negative' {
    run gawk -f all-your-base.awk -v ibase=-2 -v obase=-7 <<< "1"
    assert_failure
    assert_output    # there is _some_ output
}
