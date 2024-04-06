#!/usr/bin/env bats
load bats-extra

@test "just a number" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f wordy.awk <<< "What is 5?"
    assert_success
    assert_output "5"
}

@test "addition" {
    run gawk -f wordy.awk <<< "What is 1 plus 1?"
    assert_success
    assert_output "2"
}

@test "more addition" {
    run gawk -f wordy.awk <<< "What is 53 plus 2?"
    assert_success
    assert_output "55"
}

@test "addition with negative numbers" {
    run gawk -f wordy.awk <<< "What is -1 plus -10?"
    assert_success
    assert_output "-11"
}

@test "large addition" {
    run gawk -f wordy.awk <<< "What is 123 plus 45678?"
    assert_success
    assert_output "45801"
}

@test "subtraction" {
    run gawk -f wordy.awk <<< "What is 4 minus -12?"
    assert_success
    assert_output "16"
}

@test "multiplication" {
    run gawk -f wordy.awk <<< "What is -3 multiplied by 25?"
    assert_success
    assert_output "-75"
}

@test "division" {
    run gawk -f wordy.awk <<< "What is 33 divided by -3?"
    assert_success
    assert_output "-11"
}

@test "multiple additions" {
    run gawk -f wordy.awk <<< "What is 1 plus 1 plus 1?"
    assert_success
    assert_output "3"
}

@test "addition and subtraction" {
    run gawk -f wordy.awk <<< "What is 1 plus 5 minus -2?"
    assert_success
    assert_output "8"
}

@test "multiple subtraction" {
    run gawk -f wordy.awk <<< "What is 20 minus 4 minus 13?"
    assert_success
    assert_output "3"
}

@test "subtraction then addition" {
    run gawk -f wordy.awk <<< "What is 17 minus 6 plus 3?"
    assert_success
    assert_output "14"
}

@test "multiple multiplication" {
    run gawk -f wordy.awk <<< "What is 2 multiplied by -2 multiplied by 3?"
    assert_success
    assert_output "-12"
}

@test "addition and multiplication" {
    run gawk -f wordy.awk <<< "What is -3 plus 7 multiplied by -2?"
    assert_success
    assert_output "-8"
}

@test "multiple division" {
    run gawk -f wordy.awk <<< "What is -12 divided by 2 divided by -3?"
    assert_success
    assert_output "2"
}

@test "strict left to right, ignores typical order of operations" {
    run gawk -f wordy.awk <<< "What is 2 plus 3 multiplied by 4?"
    assert_success
    [[ $output != "14" ]]
    assert_output "20"
}

@test "unknown operation" {
    run gawk -f wordy.awk <<< "What is 52 cubed?"
    assert_failure
    assert_output "unknown operation"
}

@test "Non math question" {
    run gawk -f wordy.awk <<< "Who is the President of the United States?"
    assert_failure
    assert_output "unknown operation"
}

@test "reject problem with no operands" {
    run gawk -f wordy.awk <<< "What is plus?"
    assert_failure
    assert_output "syntax error"
}

@test "reject problem missing an operand" {
    run gawk -f wordy.awk <<< "What is 1 plus?"
    assert_failure
    assert_output "syntax error"
}

@test "reject problem with no operands or operators" {
    run gawk -f wordy.awk <<< "What is?"
    assert_failure
    assert_output "syntax error"
}

@test "reject two operations in a row" {
    run gawk -f wordy.awk <<< "What is 1 plus plus 2?"
    assert_failure
    assert_output "syntax error"
}

@test "reject two numbers in a row" {
    run gawk -f wordy.awk <<< "What is 1 plus 2 1?"
    assert_failure
    assert_output "syntax error"
}

@test "reject postfix notation" {
    run gawk -f wordy.awk <<< "What is 1 2 plus?"
    assert_failure
    assert_output "syntax error"
}

@test "reject prefix notation" {
    run gawk -f wordy.awk <<< "What is plus 1 2?"
    assert_failure
    assert_output "syntax error"
}
