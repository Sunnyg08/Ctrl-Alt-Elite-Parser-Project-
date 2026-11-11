
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
//
// Remaining Work:
// - Arithmetic expressions
// - Compound assignment operators
// - Negative numbers and parentheses
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
// ---------------------------------------

statement
    : IDENTIFIER '=' expression
    ;

// TODO - Member 2:
// Add compound assignment operators:
// +=, -=, *=, /=


// ---------------------------------------
// Part 3: Expressions
// Starter Implementation: Suneet
// ---------------------------------------

expression
    : NUMBER
    | STRING
    | IDENTIFIER
    ;

// TODO - Member 2:
// Implement arithmetic expression parsing.
// Support +, -, *, /, and %.
//
// Include:
// - Operator precedence
// - Negative numbers
// - Parentheses
// - Expressions involving variables
//
// Example:
// result = 10 + 5 * 2


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
// Coordinate with Member 2 when extending
// the expression rule.


// ---------------------------------------
// Part 5: Lexer Rules
// Basic Implementation: Suneet
// ---------------------------------------

// Integer and decimal values
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
