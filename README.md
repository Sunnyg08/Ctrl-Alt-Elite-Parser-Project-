# CS 4450 – Lightweight Python Parser

## Project Overview

This project is for CS 4450 – Principles of Programming Languages at the University of Missouri.

The objective is to develop a lightweight Python parser that can read and analyze a simplified version of Python code.

The parser will be tested using `project_deliverable_1.py`, provided by the instructor.

This project uses Python 3 without ANTLR.

## Group Members

- Suneet Ghantaji
- Wesley Harmpman
- Trevor Putthoff

## Project Files

- `parser.py` – Main parser program, currently containing the tokenizer.
- `project_deliverable_1.py` – Sample Python program supplied by the instructor.
- `README.md` – Project description and setup instructions.

## Requirements

- Python 3
- Python IDLE, VS Code, or another Python-compatible editor
- No external Python packages required for the current implementation.

## How to Run

1. Download or clone the GitHub repository.
2. Open `parser.py` using Python IDLE or VS Code.
3. Make sure `project_deliverable_1.py` is in the same folder as `parser.py`.
4. Run `parser.py` using F5 in IDLE or the following Terminal command:

   `python3 parser.py`

5. The program will read the sample file and display the recognized tokens.

## Current Progress

**Completed:**

- Created the initial Python project.
- Implemented file reading.
- Implemented tokenization using Python's built-in `tokenize` module.
- Successfully tested tokenization with the instructor's sample file.

**Remaining Work:**

- Implement syntax validation.
- Implement assignment parsing.
- Implement arithmetic expression parsing.
- Support lists and additional data types in the parser.
- Generate a parse tree.
- Implement syntax error handling.
- Test the completed parser with additional Python examples.

## Project Goal

The final program should recognize the syntax of the simplified Python language represented by the instructor's example code.

The parser should also support generalized statements rather than recognizing only the exact values and variable names in the sample.

## Notes

This project is currently in development. The initial tokenizer is complete, but the syntax parser and parse-tree generation have not yet been implemented.