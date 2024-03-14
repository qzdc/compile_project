%{
#include <stdio.h>
#include <string.h>
#include "TeaplAst.h"
#include "y.tab.hpp"
extern int line, col;
int c;
int calc(char *s, int len);
%}



%start COMMENT1 COMMENT2
%%
<INITIAL>{
    [1-9][0-9]* {
    yylval.tokenNum = A_TokenNum(A_Pos(line, col), calc(yytext, yyleng));
    col+=yyleng;
    return NUM;
}
0 {
    yylval.tokenNum = A_TokenNum(A_Pos(line, col), 0);
    ++col;
    return NUM;
}
"let" { yylval.pos = A_Pos(line, col); col+=yyleng; return LET;}
"struct" { yylval.pos = A_Pos(line, col); col+=yyleng; return STRUCT;}
"fn" { yylval.pos = A_Pos(line, col); col+=yyleng; return FN;}
"ret" { yylval.pos = A_Pos(line, col); col+=yyleng; return RETURN;}
"continue" { yylval.pos = A_Pos(line, col); col+=yyleng; return CONTINUE;}
"break" { yylval.pos = A_Pos(line, col); col+=yyleng; return BREAK;}
"if" { yylval.pos = A_Pos(line, col); col+=yyleng; return IF;}
"else" { yylval.pos = A_Pos(line, col); col+=yyleng; return ELSE;}
"while" { yylval.pos = A_Pos(line, col); col+=yyleng; return WHILE;}
"int" { yylval.pos = A_Pos(line, col); col+=yyleng; return INT;}

[_a-zA-Z][a-zA-Z0-9_]* {
    yylval.tokenId = A_TokenId(A_Pos(line, col), strdup(yytext));
    col+=yyleng;
    return ID;
    
}

"/*" { yylval.pos = A_Pos(line, col); col+=yyleng; BEGIN COMMENT1;}
"//" { yylval.pos = A_Pos(line, col); col+=yyleng; BEGIN COMMENT2;}

" " { col+=yyleng;}
"\t" { col+=4; }
"\n" { line++; col=1;}

"->" { yylval.pos = A_Pos(line, col); col+=yyleng; return ARROW;}

"+" { yylval.pos = A_Pos(line, col); col+=yyleng; return ADD;}
"-" { yylval.pos = A_Pos(line, col); col+=yyleng; return SUB;}
"*" { yylval.pos = A_Pos(line, col); col+=yyleng; return MUL;}
"/" { yylval.pos = A_Pos(line, col); col+=yyleng; return DIV;}
"&&" { yylval.pos = A_Pos(line, col); col+=yyleng; return AND;}
"||" { yylval.pos = A_Pos(line, col); col+=yyleng; return OR;}
"!" { yylval.pos = A_Pos(line, col); col+=yyleng; return NOT;}

"=" { yylval.pos = A_Pos(line, col); col+=yyleng; return ASSIGN;}
"==" { yylval.pos = A_Pos(line, col); col+=yyleng; return EQ;}
"<" { yylval.pos = A_Pos(line, col); col+=yyleng; return LT;}
">" { yylval.pos = A_Pos(line, col); col+=yyleng; return GT;}
"<=" { yylval.pos = A_Pos(line, col); col+=yyleng; return LTE;}
">=" { yylval.pos = A_Pos(line, col); col+=yyleng; return GTE;}
"!=" { yylval.pos = A_Pos(line, col); col+=yyleng; return NEQ;}

"(" { yylval.pos = A_Pos(line, col); col+=yyleng; return LPAREN1;}
")" { yylval.pos = A_Pos(line, col); col+=yyleng; return RPAREN1;}
"[" { yylval.pos = A_Pos(line, col); col+=yyleng; return LPAREN2;}
"]" { yylval.pos = A_Pos(line, col); col+=yyleng; return RPAREN2;}
"{" { yylval.pos = A_Pos(line, col); col+=yyleng; return LPAREN3;}
"}" { yylval.pos = A_Pos(line, col); col+=yyleng; return RPAREN3;}
";" { yylval.pos = A_Pos(line, col); col+=yyleng; return SEMICOLON;}
"." { yylval.pos = A_Pos(line, col); col+=yyleng; return DOT;}
"," { yylval.pos = A_Pos(line, col); col+=yyleng; return COMMA;}
":" { yylval.pos = A_Pos(line, col); col+=yyleng; return COLON;}

}

<COMMENT1>"\n" { line++; col=1;}
<COMMENT1>"*/" { col+=yyleng; BEGIN INITIAL;}
<COMMENT1>. { col+=yyleng;}

<COMMENT2>"\n" { line++; col=1; BEGIN INITIAL; }
<COMMENT2>. { col+=yyleng;}

%%

// This function takes a string of digits and its length as input, and returns the integer value of the string.
int calc(char *s, int len) {
    int ret = 0;
    for(int i = 0; i < len; i++)
        ret = ret * 10 + (s[i] - '0');
    return ret;
}