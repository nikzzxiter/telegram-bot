#!/bin/sh
# Dummy shell script 1KB

echo "Starting test..."
for i in $(seq 1 50); do
  echo "Hello from shell line $i"
done

VAR1="This is a test string to fill up size"
VAR2="Another test string to fill content"
VAR3="Looping is fun, let's make size grow"

for i in $(seq 1 20); do
  echo "$VAR1"
  echo "$VAR2"
  echo "$VAR3"
done

echo "Test shell script finished!"
