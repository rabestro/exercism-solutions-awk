#!/usr/bin/env bats
load bats-extra

@test "no rows" {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run gawk -f rectangles.awk < /dev/null
    assert_success
    assert_output "0"
}

@test "no columns" {
    run gawk -f rectangles.awk <<< ""
    assert_success
    assert_output "0"
}

@test "no rectangles" {
    run gawk -f rectangles.awk <<< " "
    assert_success
    assert_output "0"
}

@test "one rectangle" {
    run gawk -f rectangles.awk <<INPUT
+-+
| |
+-+
INPUT
    assert_success
    assert_output "1"
}

@test "two rectangles without shared parts" {
    run gawk -f rectangles.awk <<INPUT
  +-+
  | |
+-+-+
| |  
+-+  
INPUT
    assert_success
    assert_output "2"
}

@test "five rectangles with shared parts" {
    run gawk -f rectangles.awk <<INPUT
  +-+
  | |
+-+-+
| | |
+-+-+
INPUT
    assert_success
    assert_output "5"
}

@test "rectangle of height 1 is counted" {
    run gawk -f rectangles.awk <<INPUT
+--+
+--+
INPUT
    assert_success
    assert_output "1"
}

@test "rectangle of width 1 is counted" {
    run gawk -f rectangles.awk <<INPUT
++
||
++
INPUT
    assert_success
    assert_output "1"
}

@test "1x1 square is counted" {
    run gawk -f rectangles.awk <<INPUT
++
++
INPUT
    assert_success
    assert_output "1"
}

@test "only complete rectangles are counted" {
    run gawk -f rectangles.awk <<INPUT
  +-+
    |
+-+-+
| | -
+-+-+
INPUT
    assert_success
    assert_output "1"
}

@test "rectangles can be of different sizes" {
    run gawk -f rectangles.awk <<INPUT
+------+----+
|      |    |
+---+--+    |
|   |       |
+---+-------+
INPUT
    assert_success
    assert_output "3"
}

@test "corner is required for a rectangle to be complete" {
    run gawk -f rectangles.awk <<INPUT
+------+----+
|      |    |
+------+    |
|   |       |
+---+-------+
INPUT
    assert_success
    assert_output "2"
}

@test "large input with many rectangles" {
    run gawk -f rectangles.awk <<INPUT
+---+--+----+
|   +--+----+
+---+--+    |
|   +--+----+
+---+--+--+-+
+---+--+--+-+
+------+  | |
          +-+
INPUT
    assert_success
    assert_output "60"
}

@test "nested rectangles" {
    run gawk -f rectangles.awk <<INPUT
+-----------+
|           |
|      +-+  |
|      +-+  |
+-----------+
INPUT
    assert_success
    assert_output "2"
}

@test "side by side rectangles" {
    run gawk -f rectangles.awk <<INPUT
+------+ +--+
|      | |  |
+------+ |  |
         |  |
         +--+
INPUT
    assert_success
    assert_output "2"
}

@test "rectangles must have four sides" {
    run gawk -f rectangles.awk <<INPUT
+-+ +-+
| | | |
+-+-+-+
  | |  
+-+-+-+
| | | |
+-+ +-+
INPUT
    assert_success
    assert_output "5"
}
