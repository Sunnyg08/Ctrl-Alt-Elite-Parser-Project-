# CS 4450 – Lightweight Python Parser

## Project Overview

This project was developed for CS 4450 – Principles of Programming Languages at the University of Missouri–Columbia.

The goal of this project is to build a lightweight Python parser using ANTLR4. The parser recognizes a simplified version of Python syntax based on the sample programs provided by the instructor.

The project also focuses on generalization, meaning the grammar should work with different variable names, numbers, expressions, and conditional statements beyond the original sample code.

The project currently supports the requirements demonstrated in Deliverables 1 and 2.

## Group Members

1. Suneet Ghantaji
2. Wesley Harpman
3. Trevor Potthoff

## Project Files

- `LightPython.g4` – Main ANTLR4 grammar containing the lexer, parser rules, and indentation handling.
- `project_deliverable_1.py` – Instructor's sample program for Deliverable 1.
- `project_deliverable_2.py` – Instructor's sample program for Deliverable 2.
- `DELIVERABLE_2_TASKS.txt` – Group development instructions and task assignments.
- `README.md` – Project information, setup instructions, testing, and progress.
- `.gitignore` – Excludes generated files and temporary files from version control.

The repository may also contain earlier project files from the initial development stages.

## Requirements

The following tools are used to generate and test the parser:

- ANTLR4 (version 4.13.2 used during development)
- Java Development Kit (JDK)
- Terminal or command-line interface
- A text editor such as VS Code or TextEdit

The grammar uses Java code for indentation handling, so the generated Java lexer and parser must be compiled and used for testing.

No additional Python packages are required.

## Setup Instructions

### 1. Clone the Repository

Open Terminal and run:

```bash
git clone https://github.com/Sunnyg08/Ctrl-Alt-Elite-Parser-Project-.git
cd Ctrl-Alt-Elite-Parser-Project-
```

If the repository is already cloned, pull the latest changes:

```bash
git pull origin main
```

### 2. Generate the ANTLR Parser

Run:

```bash
antlr LightPython.g4
```

This generates the Java lexer, parser, listener, and other supporting files.

### 3. Compile the Generated Files

On the Mac used for testing, ANTLR4 was installed through Homebrew.

Compile using:

```bash
javac -cp "/opt/homebrew/Cellar/antlr/4.13.2/antlr-4.13.2-complete.jar:." LightPython*.java
```

The ANTLR JAR path may be different on other operating systems.

### 4. Test Deliverable 1

Run:

```bash
java -cp "/opt/homebrew/Cellar/antlr/4.13.2/antlr-4.13.2-complete.jar:." org.antlr.v4.gui.TestRig LightPython program -tree project_deliverable_1.py
```

This prints a text-based parse tree for the instructor's first sample program.

### 5. Test Deliverable 2

Run:

```bash
java -cp "/opt/homebrew/Cellar/antlr/4.13.2/antlr-4.13.2-complete.jar:." org.antlr.v4.gui.TestRig LightPython program -tree project_deliverable_2.py
```

This prints a text-based parse tree for the second sample program, including conditional statements and indented blocks.

### 6. Generate a Graphical Parse Tree

To display the Deliverable 2 parse tree visually, run:

```bash
java -cp "/opt/homebrew/Cellar/antlr/4.13.2/antlr-4.13.2-complete.jar:." org.antlr.v4.gui.TestRig LightPython program -gui project_deliverable_2.py
```

The graphical parse tree can then be exported or saved as an image for the Deliverable 2 Canvas submission.

The image must show the complete parse tree for the instructor's sample.

## Deliverable 1 – Implemented Features

The following features were implemented for Deliverable 1:

- Basic program structure
- Variable assignments
- Integer and decimal numbers
- Single-quoted and double-quoted strings
- Variable identifiers
- Arithmetic expressions (`+`, `-`, `*`, `/`, `%`)
- Compound assignments (`+=`, `-=`, `*=`, `/=`, `%=`)
- Negative numbers
- Parenthesized expressions
- Operator precedence
- Lists containing numbers, strings, and expressions
- Empty lists
- Boolean values (`True` and `False`)
- Newline handling and comments

### Deliverable 1 Testing

The grammar was tested using `project_deliverable_1.py`.

Results:

- ANTLR parser generation successful
- Generated Java files compiled successfully
- All 21 instructor sample statements parsed
- No syntax errors reported

An additional generalization test containing 9 statements was also completed successfully.

These tests included different numbers, negative values, arithmetic expressions, lists, and Boolean values.

**Deliverable 1 Status: Completed**

## Deliverable 2 – Implemented Features

Deliverable 2 extends the existing grammar to support conditional statements and logical expressions.

The following features were added:

- `if` statements
- `elif` statements
- `else` statements
- Comparison operators (`>`, `<`, `>=`, `<=`, `==`, `!=`)
- Logical operators (`and`, `or`, `not`)
- Parenthesized logical conditions
- Logical operator precedence
- Indented code blocks
- `INDENT` and `DEDENT` token generation
- Multiple statements inside conditional blocks
- Handling of tabs and spaces for indentation
- End-of-file block handling

### Conditional Statement Examples

The grammar supports syntax such as:

```python
if x > 5:
    y = 10
    z = 20
```

It also supports `if` and `else`:

```python
if x <= 10 and y == 20:
    result = 1
else:
    result = 0
```

And `if`, `elif`, and `else`:

```python
if x != 5 or y >= 10:
    flag = True
elif (not flag) and x > 2:
    flag = False
else:
    result = -1
```

### Indentation Handling

Python uses indentation to group statements into blocks.

To support this, the grammar includes Java lexer code that generates `INDENT` and `DEDENT` tokens.

The implementation tracks indentation levels using a stack. It also handles newlines, blank lines, and indentation changes.

This allows conditional statements to contain multiple assignments and separate `if`, `elif`, and `else` blocks.

### Deliverable 2 Testing

The updated grammar was tested using `project_deliverable_2.py`.

Results:

- ANTLR parser generation successful
- Generated Java files compiled successfully
- Entire instructor sample parsed
- `if`, `elif`, and `else` statements recognized
- Comparison and logical expressions recognized
- `INDENT` and `DEDENT` tokens generated
- No syntax errors reported during the sample test
- Deliverable 1 sample retested successfully

The generated parse tree showed the original assignment statements followed by the new conditional structures.

**Deliverable 2 Coding Status: Completed for the instructor's sample**

Additional generalization testing and the final graphical parse-tree image remain to be completed.

## Group Contributions

### Suneet Ghantaji

- Set up the original ANTLR4 project and GitHub repository.
- Implemented the initial grammar structure and assignment rules.
- Added lexer rules for identifiers, numbers, and strings.
- Added the Deliverable 2 conditional statement structure.
- Implemented comparison and logical condition grammar rules.
- Updated the project files and group instructions.
- Generated and compiled the updated parser.
- Tested both instructor-provided sample programs.
- Reviewed and merged the indentation implementation into the main branch.

### Wesley Harpman

- Implemented arithmetic expressions and compound assignment support.
- Worked on expression precedence.
- Implemented indentation handling for Deliverable 2.
- Added Java lexer logic to generate `INDENT` and `DEDENT` tokens.
- Updated newline and whitespace handling.
- Pushed the indentation changes through a GitHub feature branch.

### Trevor Potthoff

- Implemented list expressions for Deliverable 1.
- Added Boolean value support.
- Contributed to the original grammar development.
- Assigned to additional Deliverable 2 testing and final parse-tree image preparation.

## GitHub Collaboration

The group uses GitHub to manage the shared project.

Repository:

https://github.com/Sunnyg08/Ctrl-Alt-Elite-Parser-Project-

Group members use separate feature branches for development and testing.

Typical workflow:

```bash
git switch main
git pull origin main
git switch -c feature/your-feature-name
```

After completing changes:

```bash
git add LightPython.g4
git commit -m "Implement grammar feature"
git push -u origin feature/your-feature-name
```

A pull request can then be opened to merge changes into `main`.

The completed indentation changes for Deliverable 2 were merged into `main` under commit `6a95ee6`.

## Submission Requirements

### Deliverable 1

The instructor required the ANTLR grammar file:

- `LightPython.g4`

The generated Java files and testing files were not required.

### Deliverable 2

The instructor requires two files:

1. `LightPython.g4` – Completed Deliverable 2 grammar.
2. Parse-tree image – Graphical representation of the complete `project_deliverable_2.py` sample.

The test Python files, generated Java files, README, and group task instructions are maintained in the repository but are not required for Canvas submission.

## Project Status

**Deliverable 1: Completed and tested**

**Deliverable 2: Grammar implementation completed and instructor sample tested successfully**

Remaining tasks for Deliverable 2:

- Complete additional generalization tests.
- Generate and save the full graphical parse-tree image.
- Submit `LightPython.g4` and the parse-tree image to Canvas.

The project grammar is available on the GitHub `main` branch and has successfully parsed both instructor-provided samples without reported syntax errors.