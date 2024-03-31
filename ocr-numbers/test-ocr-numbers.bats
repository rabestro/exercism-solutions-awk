#!/usr/bin/env bats
load bats-extra


@test "No input" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f ocr-numbers.awk /dev/null
    assert_success
    assert_output ""
}

@test "Recognizes 0" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
| |
|_|
   
INPUT
    assert_success
    assert_output "0"
}

@test "Recognizes 1" {
    run gawk -f ocr-numbers.awk << INPUT
   
  |
  |
   
INPUT
    assert_success
    assert_output "1"
}

@test "Unreadable but correctly sized inputs return ?" {
    run gawk -f ocr-numbers.awk << INPUT
   
  _
  |
   
INPUT
    assert_success
    assert_output "?"
}

@test "Input with a number of lines that is not a multiple of four raises an error" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
| |
   
INPUT
    assert_failure
    assert_output "Number of input lines is not a multiple of four"
}

@test "Input with a number of columns that is not a multiple of three raises an error" {
    run gawk -f ocr-numbers.awk << INPUT
    
   |
   |
    
INPUT
    assert_failure
    assert_output "Number of input columns is not a multiple of three"
}

@test "Recognizes 110101100" {
    run gawk -f ocr-numbers.awk << INPUT
       _     _        _  _ 
  |  || |  || |  |  || || |
  |  ||_|  ||_|  |  ||_||_|
                           
INPUT
    assert_success
    assert_output "110101100"
}

@test "Garbled numbers in a string are replaced with ?" {
    run gawk -f ocr-numbers.awk << INPUT
       _     _           _ 
  |  || |  || |     || || |
  |  | _|  ||_|  |  ||_||_|
                           
INPUT
    assert_success
    assert_output "11?10?1?0"
}

@test "Recognizes 2" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
 _|
|_ 
   
INPUT
    assert_success
    assert_output "2"
}

@test "Recognizes 3" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
 _|
 _|
   
INPUT
    assert_success
    assert_output "3"
}

@test "Recognizes 4" {
    run gawk -f ocr-numbers.awk << INPUT
   
|_|
  |
   
INPUT
    assert_success
    assert_output "4"
}

@test "Recognizes 5" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
|_ 
 _|
   
INPUT
    assert_success
    assert_output "5"
}

@test "Recognizes 6" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
|_ 
|_|
   
INPUT
    assert_success
    assert_output "6"
}

@test "Recognizes 7" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
  |
  |
   
INPUT
    assert_success
    assert_output "7"
}

@test "Recognizes 8" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
|_|
|_|
   
INPUT
    assert_success
    assert_output "8"
}

@test "Recognizes 9" {
    run gawk -f ocr-numbers.awk << INPUT
 _ 
|_|
 _|
   
INPUT
    assert_success
    assert_output "9"
}

@test "Recognizes string of decimal numbers" {
    run gawk -f ocr-numbers.awk << INPUT
    _  _     _  _  _  _  _  _ 
  | _| _||_||_ |_   ||_||_|| |
  ||_  _|  | _||_|  ||_| _||_|
                              
INPUT
    assert_success
    assert_output "1234567890"
}

@test "Numbers separated by empty lines are recognized. Lines are joined by commas." {
    run gawk -f ocr-numbers.awk << INPUT
    _  _ 
  | _| _|
  ||_  _|
         
    _  _ 
|_||_ |_ 
  | _||_|
         
 _  _  _ 
  ||_||_|
  ||_| _|
         
INPUT
    assert_success
    assert_output "123,456,789"
}
