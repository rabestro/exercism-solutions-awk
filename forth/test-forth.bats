#!/usr/bin/env bats
load bats-extra

# parsing and numbers
@test numbers_only {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f forth.awk <<END
1 2 3 4 5
END
    assert_success
    assert_output "1 2 3 4 5"
}

@test "pushes negative numbers onto the stack" {
    run gawk -f forth.awk <<END
-1 -2 -3 -4 -5
END
    assert_success
    assert_output "-1 -2 -3 -4 -5"
}

# addition
@test addition_ok {
    run gawk -f forth.awk <<END
1 2 +
END
    assert_success
    assert_output "3"
}

@test addition_no_args {
    run gawk -f forth.awk <<END
+
END
    assert_failure
    assert_output --partial "empty stack"
}

@test addition_one_args {
    run gawk -f forth.awk <<END
1 +
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

# subtraction
@test subtraction_ok {
    run gawk -f forth.awk <<END
3 4 -
END
    assert_success
    assert_output "-1"
}

@test subtraction_no_args {
    run gawk -f forth.awk <<END
-
END
    assert_failure
    assert_output --partial "empty stack"
}

@test subtraction_one_args {
    run gawk -f forth.awk <<END
1 -
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

# multiplication
@test multiplication_ok {
    run gawk -f forth.awk <<END
2 4 *
END
    assert_success
    assert_output "8"
}

@test multiplication_no_args {
    run gawk -f forth.awk <<END
*
END
    assert_failure
    assert_output --partial "empty stack"
}

@test multiplication_one_args {
    run gawk -f forth.awk <<END
1 *
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

# division
@test division_ok {
    run gawk -f forth.awk <<END
12 4 /
END
    assert_success
    assert_output "3"
}

@test division_int_result {
    run gawk -f forth.awk <<END
8 3 /
END
    assert_success
    assert_output "2"
}

@test division_no_args {
    run gawk -f forth.awk <<END
/
END
    assert_failure
    assert_output --partial "empty stack"
}

@test division_one_args {
    run gawk -f forth.awk <<END
1 /
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

@test division_by_zero {
    run gawk -f forth.awk <<END
2 0 /
END
    assert_failure
    assert_output --partial "divide by zero"
}

# combined arithmetic
@test add_and_subtract {
    run gawk -f forth.awk <<END
1 2 + 4 -
END
    assert_success
    assert_output "-1"
}
@test multiply_and_divide {
    run gawk -f forth.awk <<END
2 4 * 3 /
END
    assert_success
    assert_output "2"
}

# dup
@test dup_1 {
    run gawk -f forth.awk <<END
1 dup
END
    assert_success
    assert_output "1 1"
}

@test dup_2 {
    run gawk -f forth.awk <<END
1 2 dup
END
    assert_success
    assert_output "1 2 2"
}

@test dup_empty {
    run gawk -f forth.awk <<END
dup
END
    assert_failure
    assert_output --partial "empty stack"
}

# drop
@test drop_1 {
    run gawk -f forth.awk <<END
1 drop
END
    assert_success
    assert_output ""
}

@test drop_2 {
    run gawk -f forth.awk <<END
1 2 drop
END
    assert_success
    assert_output "1"
}

@test drop_empty {
    run gawk -f forth.awk <<END
drop
END
    assert_failure
    assert_output --partial "empty stack"
}

# swap
@test swap_1 {
    run gawk -f forth.awk <<END
1 2 swap
END
    assert_success
    assert_output "2 1"
}

@test swap_2 {
    run gawk -f forth.awk <<END
1 2 3 swap
END
    assert_success
    assert_output "1 3 2"
}

@test swap_empty {
    run gawk -f forth.awk <<END
swap
END
    assert_failure
    assert_output --partial "empty stack"
}

@test swap_1arg {
    run gawk -f forth.awk <<END
1 swap
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

# over
@test over_1 {
    run gawk -f forth.awk <<END
1 2 over
END
    assert_success
    assert_output "1 2 1"
}

@test over_2 {
    run gawk -f forth.awk <<END
1 2 3 over
END
    assert_success
    assert_output "1 2 3 2"
}

@test over_empty {
    run gawk -f forth.awk <<END
over
END
    assert_failure
    assert_output --partial "empty stack"
}

@test over_1arg {
    run gawk -f forth.awk <<END
1 over
END
    assert_failure
    assert_output --partial "only one value on the stack"
}

# user-defined words
@test macro_with_builtin {
    run gawk -f forth.awk <<END
: dup-twice dup dup ;
1 dup-twice
END
    assert_success
    assert_output "1 1 1"
}

@test macro_maintain_order {
    run gawk -f forth.awk <<END
: countup 1 2 3 ;
countup
END
    assert_success
    assert_output "1 2 3"
}

@test macro_can_override_macro {
    run gawk -f forth.awk <<END
: foo dup ;
: foo dup dup ;
1 foo
END
    assert_success
    assert_output "1 1 1"
}

@test macro_can_override_builtin {
    run gawk -f forth.awk <<END
: swap dup ;
1 swap
END
    assert_success
    assert_output "1 1"
}

@test macro_can_override_operator {
    run gawk -f forth.awk <<END
: + * ;
3 4 +
END
    assert_success
    assert_output "12"
}

@test macro_expand_in_macro_definition {
    run gawk -f forth.awk <<END
: foo 5 ;
: bar foo ;
: foo 6 ;
bar foo
END
    assert_success
    assert_output "5 6"
}

@test macro_empty_definition {
    run gawk -f forth.awk <<END
: foo ;
END
    assert_failure
    assert_output --partial "empty macro definition"
}

@test macro_expand_in_macro_redefinition {
    run gawk -f forth.awk <<END
: foo 10 ;
: foo foo 1 + ;
foo
END
    assert_success
    assert_output "11"
}

@test macro_cannot_redefine_non_negative_numbers {
    run gawk -f forth.awk <<END
: 1 2 ;
END
    assert_failure
    assert_output --partial "illegal operation"
}

@test macro_cannot_redefine_negative_numbers {
    run gawk -f forth.awk <<END
: -1 2 ;
END
    assert_failure
    assert_output --partial "illegal operation"
}

@test macro_undefined {
    run gawk -f forth.awk <<END
foo
END
    assert_failure
    assert_output --partial "undefined operation"
}

@test macro_missing_semicolon {
    run gawk -f forth.awk <<END
: foo 1
foo
END
    assert_failure
    assert_output --partial "macro not terminated with semicolon"
}

# each file gets it's own forth evaluator: 
# a stack and macros, and prints the stack at the end of the file
@test each_file_gets_its_own_forth {
    echo ': + - ;' >  first.txt
    echo '1 1 +'   >> first.txt
    echo '1 1 +'   >  second.txt
    run gawk -f forth.awk first.txt second.txt
    assert_success
    assert_line --index 0 "0"
    assert_line --index 1 "2"
    rm -f first.txt second.txt
}

# case insensitivity
@test case_dup {
    run gawk -f forth.awk <<END
1 DUP Dup dup
END
    assert_success
    assert_output "1 1 1 1"
}

@test case_drop {
    run gawk -f forth.awk <<END
1 2 3 4 DROP DrOp drop
END
    assert_success
    assert_output "1"
}

@test case_swap {
    run gawk -f forth.awk <<END
1 2 SWAP 3 Swap 4 swap
END
    assert_success
    assert_output "2 3 4 1"
}

@test case_over {
    run gawk -f forth.awk <<END
1 2 OVER Over over
END
    assert_success
    assert_output "1 2 1 2 1"
}

@test case_macro_names {
    run gawk -f forth.awk <<END
: foo dup ;
1 FOO Foo foo
END
    assert_success
    assert_output "1 1 1 1"
}

@test case_macro_definitions {
    run gawk -f forth.awk <<END
: SWAP DUP Dup dup ;
1 swap
END
    assert_success
    assert_output "1 1 1 1"
}
