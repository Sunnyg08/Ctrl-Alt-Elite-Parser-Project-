grammar LightPython;

tokens { INDENT, DEDENT }

// ---------------------------------------
// Indentation Handling (INDENT / DEDENT)
// Implemented: Wesley
// ---------------------------------------
// Python uses indentation instead of braces, so the
// lexer must turn changes in leading whitespace into
// INDENT and DEDENT tokens. ANTLR has no built-in way
// to do this, so nextToken() is overridden below.
//
// How it works:
// - The NEWLINE rule also swallows any blank lines,
//   comment-only lines, and the leading tabs/spaces of
//   the next real line.
// - That leading whitespace is measured. Deeper than
//   the current level -> push it and emit INDENT.
//   Shallower -> pop levels and emit one DEDENT each.
// - At end of file, a final NEWLINE is added if the
//   last line had none, then every open block is
//   closed with DEDENTs.
// - A tab counts as moving to the next multiple of 8,
//   matching Python.
//
// NOTE: this is Java code, so the grammar must be run
// through the generated Java parser (TestRig). The
// antlr4-parse interpreter ignores this code and will
// not produce INDENT/DEDENT tokens.
@lexer::members {
    private java.util.LinkedList<Token> pending = new java.util.LinkedList<>();
    private java.util.ArrayDeque<Integer> indents = new java.util.ArrayDeque<>();
    private Token lastToken = null;

    @Override
    public Token nextToken() {
        if (indents.isEmpty()) {
            indents.push(0);
        }
        if (!pending.isEmpty()) {
            return emitPending();
        }

        Token t = super.nextToken();

        if (t.getType() == NEWLINE) {
            handleNewline(t);
            return emitPending();
        }

        if (t.getType() == EOF) {
            boolean needsNewline = lastToken != null
                && lastToken.getType() != NEWLINE
                && lastToken.getType() != LightPythonParser.DEDENT
                && lastToken.getType() != EOF;
            if (needsNewline) {
                pending.add(makeToken(NEWLINE, "\n", t));
            }
            while (indents.peek() > 0) {
                indents.pop();
                pending.add(makeToken(LightPythonParser.DEDENT, "<DEDENT>", t));
            }
            pending.add(t);
            return emitPending();
        }

        lastToken = t;
        return t;
    }

    private Token emitPending() {
        Token t = pending.poll();
        lastToken = t;
        return t;
    }

    private void handleNewline(Token t) {
        pending.add(makeToken(NEWLINE, "\n", t));

        // Indentation at end of file is handled by the EOF case
        if (_input.LA(1) == EOF) {
            return;
        }

        // Measure the whitespace after the last line break
        String text = t.getText();
        int start = Math.max(text.lastIndexOf('\n'), text.lastIndexOf('\r')) + 1;
        int width = 0;
        for (int i = start; i < text.length(); i++) {
            if (text.charAt(i) == '\t') {
                width += 8 - (width % 8);
            } else {
                width++;
            }
        }

        if (width > indents.peek()) {
            indents.push(width);
            pending.add(makeToken(LightPythonParser.INDENT, "<INDENT>", t));
        } else {
            while (width < indents.peek()) {
                indents.pop();
                pending.add(makeToken(LightPythonParser.DEDENT, "<DEDENT>", t));
            }
        }
    }

    private Token makeToken(int type, String text, Token from) {
        CommonToken token = new CommonToken(type, text);
        token.setLine(from.getLine());
        token.setCharPositionInLine(from.getCharPositionInLine());
        token.setStartIndex(from.getStartIndex());
        token.setStopIndex(from.getStartIndex() - 1);
        return token;
    }
}

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
// - INDENT and DEDENT handling
//
// Remaining Work:
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

// A block: the line break after ':', then one or
// more indented statements, closed by DEDENT.
// INDENT/DEDENT come from the lexer code at the top.
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

// Newline characters.
// Also absorbs blank lines, comment-only lines, and the
// leading indentation of the next line, so the lexer
// code at the top can measure the indentation.
NEWLINE
    : LINE_BREAK ( [ \t]* LINE_COMMENT? LINE_BREAK )* [ \t]*
    ;

fragment LINE_BREAK
    : '\r'? '\n'
    | '\r'
    ;

fragment LINE_COMMENT
    : '#' ~[\r\n]*
    ;

// Ignore comments
COMMENT
    : '#' ~[\r\n]* -> skip
    ;

// Spaces and tabs between tokens are skipped.
// Leading indentation never reaches this rule,
// because NEWLINE consumes it first.
WS
    : [ \t]+ -> skip
    ;


// ---------------------------------------
// Part 6: Testing
// Deliverable 1: Trevor
// Deliverable 2: Trevor
// ---------------------------------------

// Deliverable 1:
// Tested with project_deliverable_1.py.
// All 21 statements parsed successfully.
//
// Deliverable 2:
// Tested project_deliverable_2.py.
// Checked if, elif, else, and indentation.
// Tested additional conditional statements.
// Generated a parse tree image.
