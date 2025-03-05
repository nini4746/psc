###push_swap_checker

📌 Overview

This script runs multiple tests on the push_swap program by generating random numbers, executing the program, and evaluating its output based on sorting correctness and command efficiency.

🚀 Usage

./test_push_swap.sh <n (number of values)> <mode> <TARGET_LINES>

Parameters

n (integer): Number of values to generate for sorting.

mode (integer):

1: Space-separated numbers as arguments to push_swap

2: Numbers passed as a single string argument

TARGET_LINES (integer): The threshold number of lines to check efficiency.

Example Usage

Run a test with 5 numbers, mode 1, and check if commands exceed 12 lines:

./test_push_swap.sh 5 1 12

🛠️ How It Works

Random Number Generation

Generates n random numbers within the range of 1-10000.

Uses shuf (or gshuf on macOS) to generate randomness.

Executing push_swap

Calls ./push_swap with the generated numbers based on the selected mode.

Captures the output of the command sequence.

Validation Checks

If push_swap returns an error, it is counted as a sorting failure.

If the output contains valid commands only, it counts the number of lines.

If the line count exceeds TARGET_LINES, it is counted as an inefficient case.

Progress & Summary

Progress updates every 100 iterations.

After TOTAL_RUNS=10000, a final summary is displayed.

🔍 Valid Commands Considered

The script only counts valid push_swap operations:

sa, sb, ss, pa, pb, ra, rb, rr, rra, rrb, rrr

📊 Output Example

🔍 Running 10000 iterations to check sorting failures and cases exceeding 12 lines...
✅ Progress: 1000/10000 (Sorting failures: 3, Exceeded cases: 125)
✅ Progress: 2000/10000 (Sorting failures: 7, Exceeded cases: 278)
...
🎯 Test completed!
📌 Sorting failures: 42 out of 10000 runs
📌 Cases exceeding 12 lines: 1320 out of 10000 runs

⚠️ Notes

Ensure push_swap is compiled and executable before running the script.

Mac users might need brew install coreutils to use gshuf instead of shuf.

📢 Contributing

Feel free to submit issues or suggestions to improve this script!
