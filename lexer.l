%{
#include <stdio.h>
#include "parser.tab.h"
#include <stdlib.h>
%}

%%

"int"       { return INT; }
"float"     { return FLOAT; }
"void"      { return VOID; }
"if"        { return IF; }
"else"      { return ELSE; }
"while"     { return WHILE; }
"return"    { return RETURN; }

[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[0-9]+\.[0-9]+         { return FLOAT_NUM; }
[0-9]+                 { return INT_NUM; }

"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"="         { return '='; }
"=="        { return EQ; }
"!="        { return NE; }
"<"         { return '<'; }
">"         { return '>'; }
"{"         { return '{'; }
"}"         { return '}'; }
"("         { return '('; }
")"         { return ')'; }
","         { return ','; }
";"         { return ';'; }

[ \t\n\r]+  ; /* Skip whitespace */
.           { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}