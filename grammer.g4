grammar grammer;

program: statement+ EOF;

statement
    : variableDeclaration
    | assignment
    | ifStatement
    | forStatement
    | printStatement
    | expressionStatement
    ;

variableDeclaration
    : type ID ('=' expression)? ';'
    | type ID '[' INT ']' ';'
    ;

assignment
    : ID assignmentOperator expression ';'
    | ID '[' expression ']' assignmentOperator expression ';'
    ;

assignmentOperator
    : '='
    | '+='
    | '-='
    | '*='
    | '/='
    | '%='
    ;

printStatement
    : 'print' '(' printArgument ')' ';'
    ;

printArgument
    : expression
    | STRING ( '+' expression)*
    ;

ifStatement
    : 'if' '(' expression ')' block ('else' block)?
    ;

forStatement
    : 'for' '(' forInit?  forCondition? ';' forUpdate? ')' block
    ;

forInit
    : (variableDeclaration | assignment | expressionStatement)';'?
    ;

forCondition
    : expression ';'?
    ;

forUpdate
    : (expression | '++' | '--')';'?
    ;

block
    : '{' statement* '}'
    ;

expressionStatement
    : expression ';'
    ;

expression
    : expression op=('&&' | '||') expression  # logicalExpression
    | expression op=('==' | '!=') expression  # equalityExpression
    | expression op=('<' | '<=' | '>' | '>=') expression  # relationalExpression
    | expression op=('+' | '-') expression  # additiveExpression
    | expression op=('*' | '/' | '%') expression  # multiplicativeExpression
    | unaryOp=('++' | '--' | '+' | '-' | '!') expression  # unaryExpression
    | '(' expression ')'  # parenthesizedExpression
    | literal  # literalExpression
    | ID  # identifierExpression
    | ID '[' expression ']'  # arrayAccessExpression
    ;

literal
    : INT
    | FLOAT
    | DOUBLE
    | CHAR
    | STRING
    | BOOL
    ;

type
    : 'int'
    | 'float'
    | 'double'
    | 'char'
    | 'string'
    | 'bool'
    ;

INT: [0-9]+;

FLOAT: [0-9]+ '.' [0-9]*;

DOUBLE: [0-9]+ '.' [0-9]* 'd'?;

CHAR: '\'' . '\'';

STRING: '"' (~["\r\n] | '""')* '"';

BOOL: 'true' | 'false';

ID: [a-zA-Z_][a-zA-Z_0-9]*;

WS: [ \t\r\n]+ -> skip;

LINE_COMMENT: '//' ~[\r\n]* -> skip;
