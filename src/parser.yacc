%{
#include <stdio.h>
#include "TeaplAst.h"

extern A_pos pos;
extern A_program root;

extern int yylex(void);
extern "C"{
extern void yyerror(char *s); 
extern int  yywrap();
}

%}

// TODO:
// your parser

%union {
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
}

%token <pos> ADD
%token <pos> SUB
%token <pos> MUL
%token <pos> DIV
%token <pos> AND
%token <pos> OR
%token <pos> NOT

%token <pos> ASSIGN
%token <pos> EQ
%token <pos> NEQ
%token <pos> LT
%token <pos> GT
%token <pos> LTE
%token <pos> GTE

%token <pos> LPAREN1
%token <pos> RPAREN1
%token <pos> LPAREN2
%token <pos> RPAREN2
%token <pos> LPAREN3
%token <pos> RPAREN3
%token <pos> SEMICOLON
%token <pos> ARROW
%token <pos> DOT
%token <pos> COMMA
%token <pos> COLON

%token <pos> LET
%token <pos> STRUCT
%token <pos> FN
%token <pos> RETURN
%token <pos> CONTINUE
%token <pos> BREAK
%token <pos> IF
%token <pos> ELSE
%token <pos> WHILE
%token <pos> INT

%token <tokenId> ID
%token <tokenNum> NUM

%type <program> Program
%type <arithExpr> ArithExpr
%type <programElementList> ProgramElementList
%type <programElement> ProgramElement
%type <exprUnit> ExprUnit
%type <structDef> StructDef
%type <varDeclStmt> VarDeclStmt
%type <fnDeclStmt> FnDeclStmt
%type <fnDef> FnDef

%type <fnCall> FnCall
%type <arrayExpr> ArrayExpr
%type <arithUExpr> ArithUExpr
%type <memberExpr> MemberExpr
%type <varDecl> VarDecl
%type <varDef> VarDef
%type <varDeclScalar> VarDeclScalar 
%type <varDeclArray>  VarDeclArray 
%type <varDefScalar> VarDefScalar 
%type <varDefArray>   VarDefArray
%type <type>   Type
%type <rightValList> RightValList
%type <rightVal> RightVal
%type <indexExpr> IndexExpr
%type <boolExpr> BoolExpr
%type <boolUnit> BoolUnit
%type <comExpr> ComExpr
%type <boolUOpExpr> BoolUOpExpr
%type <varDeclList> VarDeclList
%type <fnDecl> FnDecl
%type <paramDecl> ParamDecl 
%type <codeBlockStmtList> CodeBlockStmtList
%type <codeBlockStmt> CodeBlockStmt
%type <assignStmt> AssignStmt
%type <callStmt> CallStmt
%type <ifStmt> IfStmt
%type <whileStmt> WhileStmt
%type <returnStmt> ReturnStmt
%type <leftVal> LeftVal 


%left SEMICOLON
%left LPAREN1 RPAREN1
%left IF
%left ELSE
%left WHILE
%left OR
%left AND
%left NOT
%left LT GT LTE GTE EQ
%left ADD SUB
%left MUL DIV
%left ASSIGN

%start Program

%%                   /* beginning of rules section */

Program: ProgramElementList 
{  
  root = A_Program($1);
  $$ = A_Program($1);
}
;

ProgramElementList: ProgramElement ProgramElementList
{
  $$ = A_ProgramElementList($1, $2);
}
|
{
  $$ = nullptr;
}
;

ProgramElement: VarDeclStmt
{
  $$ = A_ProgramVarDeclStmt($1->pos, $1);
}
| StructDef
{
  $$ = A_ProgramStructDef($1->pos, $1);
}
| FnDeclStmt
{
  $$ = A_ProgramFnDeclStmt($1->pos, $1);
}
| FnDef
{
  $$ = A_ProgramFnDef($1->pos, $1);
}
| SEMICOLON
{
  $$ = A_ProgramNullStmt($1);
}
;

ArithUExpr: SUB ExprUnit
{
  $$ = A_ArithUExpr($1, A_neg, $2);
}
;


ComExpr: ExprUnit EQ ExprUnit
{
  $$ = A_ComExpr($1->pos, A_eq, $1, $3);
}
| ExprUnit NEQ ExprUnit
{
  $$ = A_ComExpr($1->pos, A_ne, $1, $3);
}
| ExprUnit LT ExprUnit
{
  $$ = A_ComExpr($1->pos, A_lt, $1, $3);
}
| ExprUnit LTE ExprUnit
{
  $$ = A_ComExpr($1->pos, A_le, $1, $3);
}
| ExprUnit GT ExprUnit
{
  $$ = A_ComExpr($1->pos, A_gt, $1, $3);
}
| ExprUnit GTE ExprUnit
{
  $$ = A_ComExpr($1->pos, A_ge, $1, $3);
}
;

BoolUOpExpr: NOT BoolUnit
{
  $$ = A_BoolUOpExpr($1, A_not, $2);
}
;

ArithExpr: ArithExpr ADD ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_add, $1, $3));
}
| ArithExpr SUB ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_sub, $1, $3));
}
| ArithExpr MUL ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_mul, $1, $3));
}
| ArithExpr DIV ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_div, $1, $3));
}
| ExprUnit
{
  $$ = A_ExprUnit($1->pos, $1);
}
;

VarDeclStmt: LET VarDecl SEMICOLON
{
  $$ = A_VarDeclStmt($2->pos, $2);
}
| LET VarDef SEMICOLON 
{
  $$ = A_VarDefStmt($2->pos, $2);
}
;

VarDecl: VarDeclScalar 
{
  $$ = A_VarDecl_Scalar($1->pos, $1);
}
| VarDeclArray 
{
  $$ = A_VarDecl_Array($1->pos, $1);
};

VarDeclScalar: ID COLON Type
{
  $$ = A_VarDeclScalar($1->pos, $1->id, $3);
}
;

Type: INT
{
  $$ = A_NativeType($1, A_intTypeKind);
}
| ID
{
  $$ = A_StructType($1->pos, $1->id);
}
;

VarDeclArray: ID LPAREN2 NUM RPAREN2 COLON Type
{
  $$ = A_VarDeclArray($1->pos, $1->id, $3->num, $6);
}
;

VarDef : VarDefScalar
{
  $$ = A_VarDef_Scalar($1->pos, $1);
}
| VarDefArray
{
  $$ = A_VarDef_Array($1->pos, $1);
}
;

VarDefScalar: ID COLON Type ASSIGN RightVal
{
  $$ = A_VarDefScalar($1->pos, $1->id, $3, $5);
}
;
VarDefArray: ID LPAREN2 NUM LPAREN2 COLON Type ASSIGN LPAREN3 RightValList RPAREN3
{
  $$ = A_VarDefArray($1->pos, $1->id, $3->num, $6, $9);
}
;

RightVal : ArithExpr
{
  $$ = A_ArithExprRVal($1->pos, $1);
}
| BoolExpr
{
  $$ = A_BoolExprRVal($1->pos, $1);
}
;



ExprUnit: NUM
{
  $$ = A_NumExprUnit($1->pos, $1->num);
}
| ID
{
  $$ = A_IdExprUnit($1->pos, $1->id);
}
| LPAREN1 ArithExpr RPAREN1
{
  $$ = A_ArithExprUnit($2->pos, $2);
}
| FnCall
{
  $$ = A_CallExprUnit($1->pos, $1);
}
| ArrayExpr
{
  $$ = A_ArrayExprUnit($1->pos, $1);
}
| MemberExpr
{
  $$ = A_MemberExprUnit($1->pos, $1);
}
| ArithUExpr
{
  $$ = A_ArithUExprUnit($1->pos, $1);
}
;



ArrayExpr: LeftVal LPAREN2 IndexExpr LPAREN2
{
  $$ = A_ArrayExpr($1->pos, $1, $3);
}
;

IndexExpr: NUM
{
  $$ = A_NumIndexExpr($1->pos, $1->num);
}
| ID
{
  $$ = A_IdIndexExpr($1->pos, $1->id);
}
;

MemberExpr: LeftVal DOT ID
{
  $$ = A_MemberExpr($1->pos, $1, $3->id);
}
;

BoolExpr: BoolExpr AND BoolExpr
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_and, $1, $3));
}
| BoolExpr OR BoolExpr
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_or, $1, $3));
}
| BoolUnit
{
  $$ = A_BoolExpr($1->pos, $1);
}
;

BoolUnit: ComExpr
{
  $$ = A_ComExprUnit($1->pos, $1);
}
| LPAREN1 BoolExpr RPAREN1
{
  $$ = A_BoolExprUnit($2->pos, $2);
}
| BoolUOpExpr
{
  $$ = A_BoolUOpExprUnit($1->pos, $1);
}
;



RightValList: RightVal COMMA RightValList
{
  $$ = A_RightValList($1, $3);
}
| RightVal 
{
  $$ = A_RightValList($1, NULL);
}
;

StructDef: STRUCT ID LPAREN3 VarDeclList RPAREN3
{
  $$ = A_StructDef($2->pos, $2->id, $4);
}
;

VarDeclList: VarDecl COMMA VarDeclList
{
  $$ = A_VarDeclList($1, $3);
}
| VarDecl
{
  $$ = A_VarDeclList($1, NULL);
}
|
{
  $$ = NULL;
}
;

FnDeclStmt: FnDecl SEMICOLON
{
  $$ =  A_FnDeclStmt($1->pos, $1);
}
;

FnDecl: FN ID LPAREN1 ParamDecl RPAREN1
{
  $$ = A_FnDecl($2->pos, $2->id, $4, NULL);
}
| FN ID LPAREN1 ParamDecl RPAREN1 ARROW Type
{
  $$ = A_FnDecl($2->pos, $2->id, $4, $7);
}
;

ParamDecl: VarDeclList
{
  $$ = A_ParamDecl($1);
}
;

FnDef: FnDecl LPAREN3 CodeBlockStmtList RPAREN3
{
  $$ = A_FnDef($1->pos, $1, $3);
}
;

CodeBlockStmtList: CodeBlockStmt CodeBlockStmtList
{
  $$ = A_CodeBlockStmtList($1, $2);
}
| CodeBlockStmt
{
  $$ = A_CodeBlockStmtList($1, NULL);
}
;

CodeBlockStmt: SEMICOLON
{
  $$ = A_BlockNullStmt($1);
}
| VarDeclStmt
{
  $$ = A_BlockVarDeclStmt($1->pos, $1);
}
| AssignStmt
{
  $$ = A_BlockAssignStmt($1->pos, $1);
}
| CallStmt
{
  $$ = A_BlockCallStmt($1->pos, $1);
}
| IfStmt
{
  $$ = A_BlockIfStmt($1->pos, $1);
}
| WhileStmt
{
  $$ = A_BlockWhileStmt($1->pos, $1);
}
| ReturnStmt
{
  $$ = A_BlockReturnStmt($1->pos, $1);
}
| CONTINUE SEMICOLON
{
  $$ = A_BlockContinueStmt($1);
}
| BREAK SEMICOLON
{
  $$ = A_BlockBreakStmt($1);
}
;

AssignStmt: LeftVal ASSIGN RightVal SEMICOLON
{
  $$ = A_AssignStmt($1->pos, $1, $3);
}
;

LeftVal: ID
{
  $$ = A_IdExprLVal($1->pos, $1->id);
}
| ArrayExpr
{
  $$ = A_ArrExprLVal($1->pos, $1);
}
| MemberExpr{
  $$ = A_MemberExprLVal($1->pos, $1);
}
;

ArrayExpr: LeftVal LPAREN2 IndexExpr RPAREN2
{
  $$ = A_ArrayExpr($1->pos, $1, $3);
}
;

CallStmt: FnCall SEMICOLON
{
  $$ = A_CallStmt($1->pos, $1);
}
;

FnCall: ID LPAREN1 RightValList RPAREN1
{
  $$ = A_FnCall($1->pos, $1->id, $3);
}
| ID LPAREN1 RPAREN1
{
  $$ = A_FnCall($1->pos, $1->id, NULL);
}
;

IfStmt: IF LPAREN1 BoolExpr RPAREN1 LPAREN3 CodeBlockStmtList RPAREN3
{
  $$ = A_IfStmt($1, $3, $6, NULL);
}
| IF LPAREN1 BoolExpr RPAREN1 LPAREN3 CodeBlockStmtList RPAREN3 ELSE LPAREN3 CodeBlockStmtList RPAREN3
{
  $$ = A_IfStmt($1, $3, $6, $10);
}
;

WhileStmt: WHILE LPAREN1 BoolExpr RPAREN1 LPAREN3 CodeBlockStmtList RPAREN3
{
  $$ = A_WhileStmt($1, $3, $6);
}
;

ReturnStmt: RETURN RightVal SEMICOLON
{
  $$ = A_ReturnStmt($1, $2);
}
| RETURN SEMICOLON
{
  $$ = A_ReturnStmt($1, NULL);
}
;




%%

extern "C"{
void yyerror(char * s)
{
  extern int yylineno;	// defined and maintained in lex
	extern char *yytext;	// defined and maintained in lex
  extern int yyleng;
  extern int line, col;
	int len=yyleng;
	int i;
	char buf[512]={0};
	for (i=0;i<len;++i)
	{
		sprintf(buf,"%s%d ",buf,yytext[i]);
	}
  fprintf(stderr,"ERROR: %s at line %d, column %d\n", s, line, col);
	yyparse();
}
int yywrap()
{
  return(1);
}
}


