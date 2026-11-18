
grammar LightPython;

tokens { INDENT, DEDENT }

// CS 4450 - Principles of Programming Languages
// Project Deliverable 2 - Lightweight Python Parser
//
// Group Members:
// 1. Suneet Ghantaji
// 2. Wesley Harpman
// 3. Trevor Potthoff
//
// Purpose:
// Extend our ANTLR4 grammar to support
// conditional statements in Python.
//
// Deliverable 1:
// - Basic variable assignments
// - Arithmetic expressions
// - Compound assignments
// - Numbers and strings
// - Lists and Boolean values
// - Negative numbers and parentheses
//
// Deliverable 2 Progress:
// - Comparison operators
// - Logical operators
// - if, elif, and else grammar rules
// - Basic block structure
//
// Remaining Work:
// - Implement INDENT and DEDENT handling
// - Test the complete Deliverable 2 sample
// - Generate the final parse tree image


// ---------------------------------------
// Part 1: Program Structure
// Implemented: Suneet
// Updated for Deliverable 2
// ---------------------------------------

program
    : (NEWLINE | statement)* simpleStatement? EOF
    ;


// ---------------------------------------
// Part 2: Assignment Statements
// Implemented: Suneet
// Compound assignments: Wesley
// ---------------------------------------

// A statement can be a regular assignment
// or a conditional statement.
statement
    : simpleStatement NEWLINE
    | ifStatement
    ;

simpleStatement
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
// Part 2B: Conditional Statements
// Implemented: Suneet
// ---------------------------------------

// Supports if, elif, and else statements.
// Each condition is followed by a code block.
ifStatement
    : IF condition ':' suite
      (ELIF condition ':' suite)*
      (ELSE ':' suite)?
    ;

// TODO - Wesley:
// Complete indentation handling.
// The lexer must generate INDENT and DEDENT.
// This rule will be tested after that is done.
suite
    : NEWLINE INDENT
      (NEWLINE | statement)+
      DEDENT
    ;


// ---------------------------------------
// Part 3: Arithmetic Expressions
// Starter Implementation: Suneet
// Arithmetic: Wesley
// ---------------------------------------

// Operator precedence:
// 1. Parentheses
// 2. Unary minus
// 3. Multiplication, division, modulo
// 4. Addition and subtraction
//
// Binary operations are left-associative.
expression
    : '(' expression ')'                          # parenExpr
    | '-' expression                              # negateExpr
    | expression op=('*' | '/' | '%') expression   # mulDivModExpr
    | expression op=('+' | '-') expression         # addSubExpr
    | atom                                        # atomExpr
    ;

// Values, variable references, lists,
// and Boolean values.
atom
    : NUMBER
    | STRING
    | IDENTIFIER
    | lists
    | TRUE
    | FALSE
    ;


// ---------------------------------------
// Part 3B: Conditions
// Implemented: Suneet
// ---------------------------------------

// Logical OR has the lowest precedence.
condition
    : orCondition
    ;

orCondition
    : andCondition (OR andCondition)*
    ;

// Logical AND
andCondition
    : notCondition (AND notCondition)*
    ;

// Logical NOT and grouped conditions
notCondition
    : NOT notCondition
    | '(' condition ')'
    | comparison
    ;

// Comparison expressions
comparison
    : expression (comparisonOp expression)*
    ;

// Comparison operators
comparisonOp
    : '>'
    | '<'
    | '>='
    | '<='
    | '=='
    | '!='
    ;


// ---------------------------------------
// Part 4: Lists and Boolean Values
// Implemented: Trevor
// ---------------------------------------

// Supports empty lists and lists
// containing multiple expressions.
lists
    : '[' (expression (',' expression)*)? ']'
    ;

// Boolean values
TRUE
    : 'True'
    ;

FALSE
    : 'False'
    ;


// ---------------------------------------
// Part 5: Lexer Rules
// Basic Implementation: Suneet
// Deliverable 2 Keywords: Suneet
// ---------------------------------------

// Integer and decimal values.
// Negative values are handled by expression.
NUMBER
    : [0-9]+ ('.' [0-9]+)?
    ;

// Strings using single or double quotes
STRING
    : '"' ( '\\' . | ~["\\\r\n] )* '"'
    | '\'' ( '\\' . | ~['\\\r\n] )* '\''
    ;

// Conditional keywords
IF
    : 'if'
    ;

ELIF
    : 'elif'
    ;

ELSE
    : 'else'
    ;

// Logical keywords
AND
    : 'and'
    ;

OR
    : 'or'
    ;

NOT
    : 'not'
    ;

// Variable identifiers
IDENTIFIER
    : [a-zA-Z_] [a-zA-Z_0-9]*
    ;

// Newline characters
NEWLINE
    : '\r'? '\n'
    | '\r'
    ;

// Ignore comments
COMMENT
    : '#' ~[\r\n]* -> skip
    ;

// TODO - Wesley:
// Currently spaces and tabs are skipped.
// Update this logic so that leading
// indentation generates INDENT/DEDENT.
//
// Blank lines, tabs, spaces, and the end
// of the file need to be handled properly.
WS
    : [ \t]+ -> skip
    ;


// ---------------------------------------
// Part 6: Testing
// Deliverable 1: Group Members
// Deliverable 2: Trevor and Group
// ---------------------------------------

// Deliverable 1:
// Tested with project_deliverable_1.py.
// All 21 statements parsed successfully.
//
// Deliverable 2:
// TODO - Test project_deliverable_2.py.
// Check if, elif, else, and indentation.
// Test additional conditional statements.
// Generate a parse tree image.
//
// Final testing will be completed after
// the indentation rules are implemented.
