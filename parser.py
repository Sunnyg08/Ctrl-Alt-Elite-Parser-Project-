
# CS 4450 - Principles of Programming Languages
# Project Deliverable 1 - Lightweight Python Parser
#
# Purpose:
# Create a parser that can read and analyze a
# simplified version of Python.
#
# Group Members:
# 1.Suneet Ghantaji
# 2.
# 3.
#
# Project Status:
# Initial tokenizer implemented and tested.
# Successfully tokenizes project_deliverabel_1.py
# Remaining work:
#
# - Implement syntax validation 
# - Implement expression parsing
# - Implement assignment parsing
# - Generate parse tree
# - Add error handling
#
#


import tokenize
import io
from pathlib import Path


# Step 1: Read the Python source file
def read_file(filename):
    try:
        with open(filename, "r") as file:
            code = file.read()

        print("File loaded successfully!")
        return code

    except FileNotFoundError:
        print("Error: File not found.")
        return None


# Step 2: Convert source code into tokens
def tokenize_code(code):
    tokens = []

    source = io.BytesIO(code.encode("utf-8"))

    for token in tokenize.tokenize(source.readline):

        # Ignore formatting tokens for now
        if token.type not in (
            tokenize.ENCODING,
            tokenize.NL,
            tokenize.NEWLINE,
            tokenize.ENDMARKER
        ):
            tokens.append((tokenize.tok_name[token.type],
                           token.string))

    return tokens


# Step 3: Display the tokens
def display_tokens(tokens):
    print("\nTokens:")
    print("-" * 40)

    for token_type, token_value in tokens:
        print(token_type, ":", token_value)


# Step 4: Main program
def main():

    print("CS 4450 - Python Parser Project")
    print("=" * 40)

    project_folder = Path(__file__).resolve().parent
    filename = project_folder / "project_deliverable_1.py"

    code = read_file(filename)

    if code is not None:

        tokens = tokenize_code(code)

        display_tokens(tokens)

        print("\nTokenization complete!")
        print("Parser implementation is next.")


if __name__ == "__main__":
    main()
