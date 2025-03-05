#!/bin/bash

# Check parameters
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <n (number of values)> <mode> <TARGET_LINES>"
    echo "mode: 1 (space-separated) | 2 (string argument)"
    exit 1
fi

# Number of values, mode selection, and target line count
n=$1
mode=$2
TARGET_LINES=$3

COUNT_EXCEED=0  # Count of exceeding target lines
COUNT_FAIL=0    # Count of sorting failures
TOTAL_RUNS=10000  # Number of iterations

# Determine the appropriate shuffle command based on OS
if command -v gshuf &> /dev/null; then
    SHUF_CMD="gshuf"
else
    SHUF_CMD="shuf"
fi

echo "🔍 Running $TOTAL_RUNS iterations to check sorting failures and cases exceeding $TARGET_LINES lines..."

VALID_COMMANDS=("sa" "sb" "ss" "pa" "pb" "ra" "rb" "rr" "rra" "rrb" "rrr")

for ((i=1; i<=TOTAL_RUNS; i++)); do
    numbers=$($SHUF_CMD -i 1-10000 -n $n | tr '\n' ' ')  # Generate random numbers

    # Change push_swap execution method based on mode
    if [ "$mode" -eq 1 ]; then
        output=$(./push_swap $numbers)
    elif [ "$mode" -eq 2 ]; then
        output=$(./push_swap "$numbers")
    else
        echo "❌ Invalid mode. Choose 1 or 2."
        exit 1
    fi

    # Check push_swap return value
    EXIT_CODE=$?
    if [ "$EXIT_CODE" -ne 0 ]; then
        ((COUNT_FAIL++))  # Increase sorting failure count
    else
        # Only count valid commands
        line_count=$(echo "$output" | grep -E "^($(IFS='|'; echo "${VALID_COMMANDS[*]}")$)" | wc -l)
        if [ "$line_count" -ge "$TARGET_LINES" ]; then
            ((COUNT_EXCEED++))
        fi
    fi

    # Display progress
    if (( i % 100 == 0 )); then
        echo "✅ Progress: $i/$TOTAL_RUNS (Sorting failures: $COUNT_FAIL, Exceeded cases: $COUNT_EXCEED)"
    fi

done

# Print final results
echo "🎯 Test completed!"
echo "📌 Sorting failures: $COUNT_FAIL out of $TOTAL_RUNS runs"
echo "📌 Cases exceeding $TARGET_LINES lines: $COUNT_EXCEED out of $TOTAL_RUNS runs"
