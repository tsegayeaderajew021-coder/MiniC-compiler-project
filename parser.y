%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
int yyparse();
%}

%token INT FLOAT VOID IF ELSE WHILE RETURN IDENTIFIER INT_NUM FLOAT_NUM EQ NE

%%

program:
    external_declarations
    ;

external_declarations:
    external_declarations external_declaration
    | external_declaration
    ;

external_declaration:
    variable_declaration ';'
    | function_definition
    ;

function_definition:
    type IDENTIFIER '(' parameter_list_opt ')' '{' statements '}'
    ;

parameter_list_opt:
    parameter_list
    | /* empty */
    ;

parameter_list:
    parameter_list ',' parameter
    | parameter
    ;

parameter:
    type IDENTIFIER
    ;

type:
    INT
    | FLOAT
    | VOID
    ;

statements:
    statements statement
    | statement
    ;

statement:
    variable_declaration ';'
    | assignment_statement ';'
    | if_statement
    | while_statement
    | return_statement ';'
    ;

variable_declaration:
    type IDENTIFIER
    | type IDENTIFIER '=' expression
    ;

assignment_statement:
    IDENTIFIER '=' expression
    ;

expression:
    expression '+' term
    | expression '-' term
    | term
    ;

term:
    term '*' factor
    | term '/' factor
    | factor
    ;

factor:
    IDENTIFIER
    | INT_NUM
    | FLOAT_NUM
    | IDENTIFIER '(' argument_list_opt ')'
    | '(' expression ')'
    ;

argument_list_opt:
    argument_list
    | /* empty */
    ;

argument_list:
    argument_list ',' expression
    | expression
    ;

if_statement:
    IF '(' condition ')' '{' statements '}'
    | IF '(' condition ')' '{' statements '}' ELSE '{' statements '}'
    ;

while_statement:
    WHILE '(' condition ')' '{' statements '}'
    ;

return_statement:
    RETURN expression
    | RETURN
    ;

condition:
    expression EQ expression
    | expression NE expression
    | expression '<' expression
    | expression '>' expression
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    printf("Starting MiniC Compiler (Supports Float, If-Else, While, Functions)...\n");
    yyparse();
    return 0;
}