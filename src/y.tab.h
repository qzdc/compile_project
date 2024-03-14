/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    ADD = 258,                     /* ADD  */
    SUB = 259,                     /* SUB  */
    MUL = 260,                     /* MUL  */
    DIV = 261,                     /* DIV  */
    AND = 262,                     /* AND  */
    OR = 263,                      /* OR  */
    NOT = 264,                     /* NOT  */
    ASSIGN = 265,                  /* ASSIGN  */
    EQ = 266,                      /* EQ  */
    NEQ = 267,                     /* NEQ  */
    LT = 268,                      /* LT  */
    GT = 269,                      /* GT  */
    LTE = 270,                     /* LTE  */
    GTE = 271,                     /* GTE  */
    LPAREN1 = 272,                 /* LPAREN1  */
    RPAREN1 = 273,                 /* RPAREN1  */
    LPAREN2 = 274,                 /* LPAREN2  */
    RPAREN2 = 275,                 /* RPAREN2  */
    LPAREN3 = 276,                 /* LPAREN3  */
    RPAREN3 = 277,                 /* RPAREN3  */
    SEMICOLON = 278,               /* SEMICOLON  */
    ARROW = 279,                   /* ARROW  */
    DOT = 280,                     /* DOT  */
    COMMA = 281,                   /* COMMA  */
    COLON = 282,                   /* COLON  */
    LET = 283,                     /* LET  */
    STRUCT = 284,                  /* STRUCT  */
    FN = 285,                      /* FN  */
    RETURN = 286,                  /* RETURN  */
    CONTINUE = 287,                /* CONTINUE  */
    BREAK = 288,                   /* BREAK  */
    IF = 289,                      /* IF  */
    ELSE = 290,                    /* ELSE  */
    WHILE = 291,                   /* WHILE  */
    INT = 292,                     /* INT  */
    ID = 293,                      /* ID  */
    NUM = 294                      /* NUM  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define ADD 258
#define SUB 259
#define MUL 260
#define DIV 261
#define AND 262
#define OR 263
#define NOT 264
#define ASSIGN 265
#define EQ 266
#define NEQ 267
#define LT 268
#define GT 269
#define LTE 270
#define GTE 271
#define LPAREN1 272
#define RPAREN1 273
#define LPAREN2 274
#define RPAREN2 275
#define LPAREN3 276
#define RPAREN3 277
#define SEMICOLON 278
#define ARROW 279
#define DOT 280
#define COMMA 281
#define COLON 282
#define LET 283
#define STRUCT 284
#define FN 285
#define RETURN 286
#define CONTINUE 287
#define BREAK 288
#define IF 289
#define ELSE 290
#define WHILE 291
#define INT 292
#define ID 293
#define NUM 294

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 19 "parser.yacc"

  A_pos pos;
  A_program program;
  A_programElementList programElementList;
  A_programElement programElement;
  A_arithExpr arithExpr;
  A_exprUnit exprUnit;
  A_structDef structDef;
  A_varDeclStmt varDeclStmt;
  A_fnDeclStmt fnDeclStmt;

  A_tokenId tokenId;
  A_tokenNum tokenNum;

  A_arrayExpr arrayExpr;
  A_fnDef fnDef;
  A_fnCall fnCall;
  A_arithUExpr arithUExpr;
  A_arithBiOpExpr arithBiOpExpr;
  A_memberExpr memberExpr;
  A_varDecl varDecl;
  A_varDef varDef;
  A_varDeclScalar varDeclScalar;
  A_varDeclArray varDeclArray;
  A_varDefScalar varDefScalar; 
  A_type type;
  A_varDefArray varDefArray;
  A_rightVal rightVal;
  A_rightValList rightValList;
  A_indexExpr indexExpr;
  A_boolExpr boolExpr;
  A_boolUnit boolUnit;
  A_comExpr comExpr; 
  A_boolUOpExpr boolUOpExpr;
  A_varDeclList varDeclList;
  A_fnDecl fnDecl;
  A_paramDecl paramDecl;
  A_codeBlockStmtList codeBlockStmtList;
  A_boolBiOp boolBiOp;
  A_codeBlockStmt codeBlockStmt;
  A_assignStmt assignStmt;
  A_callStmt callStmt;
  A_ifStmt ifStmt;
  A_whileStmt whileStmt;
  A_returnStmt returnStmt;
  A_leftVal leftVal;

#line 193 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
