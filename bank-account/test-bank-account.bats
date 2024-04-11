#!/usr/bin/env bats
load bats-extra

@test "Newly opened account has zero balance" {
    run gawk -f bank-account.awk <<END_INPUT
open
balance
END_INPUT
    assert_success
    assert_output "0"
}

@test "Single deposit" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 100
balance
END_INPUT
    assert_success
    assert_output "100"
}

@test "Multiple deposits" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 100
deposit 50
balance
END_INPUT
    assert_success
    assert_output "150"
}

@test "Withdraw once" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 100
withdraw 75
balance
END_INPUT
    assert_success
    assert_output "25"
}

@test "Withdraw twice" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 100
withdraw 80
withdraw 20
balance
END_INPUT
    assert_success
    assert_output "0"
}

@test "Can do multiple operations sequentially" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 100
deposit 110
withdraw 200
deposit 60
withdraw 50
balance
END_INPUT
    assert_success
    assert_output "20"
}

@test "Cannot check balance of closed account" {
    run gawk -f bank-account.awk <<END_INPUT
open
close
balance
END_INPUT
    assert_failure
    assert_output "account not open"
}

@test "Cannot deposit into closed account" {
    run gawk -f bank-account.awk <<END_INPUT
open
close
deposit 50
END_INPUT
    assert_failure
    assert_output "account not open"
}

@test "Cannot deposit into unopened account" {
    run gawk -f bank-account.awk <<END_INPUT
deposit 50
END_INPUT
    assert_failure
    assert_output "account not open"
}

@test "Cannot withdraw from closed account" {
    run gawk -f bank-account.awk <<END_INPUT
open
close
withdraw 50
END_INPUT
    assert_failure
    assert_output "account not open"
}

@test "Cannot close an account that was not opened" {
    run gawk -f bank-account.awk <<END_INPUT
close
END_INPUT
    assert_failure
    assert_output "account not open"
}

@test "Cannot open an already opened account" {
    run gawk -f bank-account.awk <<END_INPUT
open
open
END_INPUT
    assert_failure
    assert_output "account already open"
}

@test "Reopened account does not retain balance" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 50
close
open
balance
END_INPUT
    assert_success
    assert_output "0"
}

@test "Cannot withdraw more than deposited" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 25
withdraw 50
END_INPUT
    assert_failure
    assert_output "amount must be less than balance"
}

@test "Cannot withdraw negative" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit 100
withdraw -50
END_INPUT
    assert_failure
    assert_output "amount must be greater than 0"
}

@test "Cannot deposit negative" {
    run gawk -f bank-account.awk <<END_INPUT
open
deposit -50
END_INPUT
    assert_failure
    assert_output "amount must be greater than 0"
}

# The last test case "Can handle concurrent transactions" is not applicable in AWK as it does not support concurrency.
