# CS 4450 – Lightweight Python Parser

## Project Overview

This project is being developed for CS 4450 – Principles of Programming Languages at the University of Missouri–Columbia.

The goal of this project is to create a lightweight Python parser using ANTLR4. The parser will recognize and analyze a simplified version of Python syntax based on the sample code provided by the instructor.

The parser should also support generalization, meaning it must recognize different variable names, numeric values, and expressions beyond those included in the original sample.

## Group Members

1. Suneet Ghantaji
2. Wesley Harpman
3. Trevor Potthoff

## Project Files

- `LightPython.g4` – Main ANTLR4 grammar file containing the lexer and parser rules.
- `project_deliverable_1.py` – Sample Python program provided by the instructor for testing.
- `README.md` – Project documentation, setup instructions, and development progress.
- `.gitignore` – Excludes generated ANTLR files and temporary files from version control.

## Requirements

The following tools are required to generate and test the parser locally:

- ANTLR4 (version 4.13.2 used during initial testing)
- Java Development Kit (JDK)
- Terminal or command-line interface
- Any text editor, such as VS Code or TextEdit

No Python packages are required to generate and test the ANTLR4 Java parser.

ANTLR Lab (https://lab.antlr.org/) may also be used for browser-based testing.

## Setup Instructions

### 1. Clone the Repository

Open Terminal and run:

```bash
git clone https://github.com/Sunnyg08/Ctrl-Alt-Elite-Parser-Project-.git
cd Ctrl-Alt-Elite-Parser-Project-
```

### 2. Generate the ANTLR Parser

Run:

```bash
antlr LightPython.g4
```

This generates the Java lexer, parser, listener, and supporting files from the grammar.

### 3. Compile the Generated Files

For the Homebrew ANTLR 4.13.2 installation used during initial testing on macOS:

```bash
javac -cp "/opt/homebrew/Cellar/antlr/4.13.2/antlr-4.13.2-complete.jar:." LightPython*.java
```

The ANTLR JAR location may differ depending on the operating system and installation method.

### 4. Test the Parser

To test the current starter grammar, create a file named `starter_test.py` containing:

```python
assign1 = "20"
assign2 = 123
assign3 = 1.23
assign4 = assign1
```

Run:

```bash
java -cp "/opt/homebrew/Cellar/antlr/4.13.2/antlr-4.13.2-complete.jar:." org.antlr.v4.gui.TestRig LightPython program -tree starter_test.py
```

This command generates a text-based parse tree.

After all grammar features have been implemented, replace `starter_test.py` with `project_deliverable_1.py` to test the instructor's complete sample.

## Current Progress

### Completed – Initial Grammar Setup

- Created the `LightPython.g4` ANTLR4 grammar file.
- Implemented basic program structure.
- Implemented simple variable assignment statements.
- Added lexer rules for variable identifiers.
- Added support for integer and decimal values.
- Added support for single-quoted and double-quoted strings.
- Implemented newline handling and comment skipping.
- Successfully generated the ANTLR Java parser files.
- Successfully compiled the generated Java files.
- Successfully generated a parse tree for four basic assignment statements.

### Initial Test Results

The starter grammar was tested using:

```python
assign1 = "20"
assign2 = 123
assign3 = 1.23
assign4 = assign1
```

All four statements were successfully parsed without reported syntax errors.

The initial test confirms that basic assignments, numbers, strings, and variable references are recognized.

## Remaining Work and Group Responsibilities

### Member 2 – Arithmetic Expressions and Operators

Implement the following features in `LightPython.g4`:

- Addition (`+`)
- Subtraction (`-`)
- Multiplication (`*`)
- Division (`/`)
- Modulo (`%`)
- Compound assignment operators (`+=`, `-=`, `*=`, `/=`)
- Negative numbers
- Parenthesized expressions
- Operator precedence

Example statements to support:

```python
result = 10 + 5
total = 4 * 3
value = 20 / 2 + 5
number = -1000
result += 10
```

### Member 3 – Lists, Boolean Values, and Testing

Implement and verify:

- List expressions using square brackets.
- Lists containing integers, decimals, and strings.
- Boolean values (`True` and `False`).
- Additional generalized test cases.
- Testing the complete instructor-provided sample.
- Identifying and resolving remaining syntax errors.

Example statements to support:

```python
numbers = [1, 2, 3, 4, 5]
letters = ['a', 'b', 'c']
values = [1.5, 2.5, 3.5]
flag = True
```

### All Group Members – Final Integration

After completing the assigned sections, all members should:

1. Merge their grammar changes into the main project.
2. Review the grammar rules for compatibility.
3. Regenerate the ANTLR parser.
4. Compile the generated parser files.
5. Test the full `project_deliverable_1.py` file.
6. Confirm the entire sample generates a parse tree without syntax errors.
7. Test generalized examples not included in the instructor's sample.
8. Review and finalize the grammar before submission.

## GitHub Collaboration

Group members should work on separate Git branches to reduce conflicts.

Before starting work, pull the latest changes:

```bash
git pull origin main
```

Create a feature branch:

```bash
git switch -c feature/your-feature-name
```

After completing work, stage and commit the changes:

```bash
git add LightPython.g4
git commit -m "Implement grammar feature"
git push -u origin feature/your-feature-name
```

Create a pull request on GitHub to merge completed changes into the main branch.

## Submission Requirements

According to the instructor's Deliverable 1 instructions, groups using ANTLR should submit only their completed `.g4` grammar files.

For this project, the intended submission is:

`LightPython.g4`

The final grammar must successfully parse the instructor's provided sample and support generalized versions of the demonstrated Python syntax.

The automatically generated Java files, Python sample file, and README are maintained for development and testing but are not required for the ANTLR submission.

## Project Status

**In Progress – Initial ANTLR4 Grammar Completed**

Basic assignment parsing has been implemented and successfully tested.

Arithmetic expressions, compound assignments, list syntax, Boolean values, and full-sample verification remain to be completed before final submission.