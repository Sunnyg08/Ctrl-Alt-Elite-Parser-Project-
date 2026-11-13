grammar LightPython;

// CS 4450 - Principles of Programming Languages
// Project Deliverable 1 - Lightweight Python Parser
//
// Group Members:
// 1. Suneet Ghantaji
// 2. Wesley Harpman
// 3. Trevor Potthoff
//
// Purpose:
// Build an ANTLR4 grammar for a simplified
// version of the Python programming language.
//
// Current Progress:
// - Basic program structure
// - Simple variable assignments
// - Integer and decimal numbers
// - Strings and variable identifiers
// - Arithmetic expressions (+, -, *, /, %)
// - Compound assignment operators
// - Negative numbers and parentheses
//
// Remaining Work:
// - Lists and Boolean values
// - Full sample testing and error handling


// ---------------------------------------
// Part 1: Program Structure
// Implemented: Suneet
// ---------------------------------------

program
    : (NEWLINE | statement NEWLINE)* statement? EOF
    ;


// ---------------------------------------
// Part 2: Assignment Statements
// Implemented: Suneet
// Compound assignment: Wesley
// ---------------------------------------

statement
    : IDENTIFIER assignOp expression
    ;

// Plain and compound assignment operators
assignOp
    : '='
    | '+='
    | '-='
    | '*='
    | '/='
    | '%='
    ;


// ---------------------------------------
// Part 3: Expressions
// Starter Implementation: Suneet
// Arithmetic: Wesley
// ---------------------------------------

// Precedence: alternatives listed first bind tightest.
//   1. Parentheses
//   2. Negation (unary minus): -1000, -x, -(a + b)
//   3. Multiplication, division, modulo
//   4. Addition, subtraction
// Binary operators are left-associative:
//   10 - 3 - 2 is parsed as (10 - 3) - 2
expression
    : '(' expression ')'                          # parenExpr
    | '-' expression                              # negateExpr
    | expression op=('*' | '/' | '%') expression  # mulDivModExpr
    | expression op=('+' | '-') expression        # addSubExpr
    | atom                                        # atomExpr
    ;

// Single values. Lists and True/False can be
// added here as new alternatives.
atom
    : NUMBER
    | STRING
    | IDENTIFIER
    ;


// ---------------------------------------
// Part 4: Lists and Boolean Values
// TODO - Whoever wants it
// ---------------------------------------

// Implement list expressions.
//
// Examples:
// array1 = [1, 2, 3]
// array2 = ['a', 'b', 'c']
//
// Also add Boolean literals:
// flag = True
// flag = False
//
// Add both as new alternatives in the atom rule
// above. Define TRUE/FALSE lexer rules ABOVE
// IDENTIFIER so they aren't matched as names.


// ---------------------------------------
// Part 5: Lexer Rules
// Basic Implementation: Suneet
// ---------------------------------------

// Integer and decimal values.
// No leading '-' on purpose: negative numbers are
// handled by negateExpr. Otherwise "x-1" would lex
// as IDENTIFIER NUMBER(-1) and fail to parse.
NUMBER
    : [0-9]+ ('.' [0-9]+)?
    ;

// Strings using single or double quotes
STRING
    : '"' ( '\\' . | ~["\\\r\n] )* '"'
    | '\'' ( '\\' . | ~['\\\r\n] )* '\''
    ;

// Variable names
IDENTIFIER
    : [a-zA-Z_] [a-zA-Z_0-9]*
    ;

// New lines
NEWLINE
    : '\r'? '\n'
    | '\r'
    ;

// Ignore comments
COMMENT
    : '#' ~[\r\n]* -> skip
    ;

// Ignore spaces and tabs
WS
    : [ \t]+ -> skip
    ;


// ---------------------------------------
// Part 6: Testing
// TODO - whoever wants it
// ---------------------------------------

// Test the completed grammar using:
// project_deliverable_1.py
//
// Use https://lab.antlr.org/
//
// Verify that the entire sample parses
// with no syntax errors.
//
// Test generalization:
// x = 5
// x = 666
// x = -1000
// total = 4 + 3 * 2
