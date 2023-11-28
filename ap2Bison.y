%{
#include <stdlib.h>
#include <stdio.h>

/*
flex -o ap2Flex.c ap2Flex.l ; bison -d ap2Bison.y ; gcc -o ap2 ap2Flex.c ap2Bison.tab.c -lfl -lm ; ./ap2
*/
extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror (const char* s); 

%}

%union {
    int ival;
    char* sval;
}

%token VAR
%token PRINT
%token<sval> ID
%token OP_ATT
%token OP_SOM OP_SUB OP_MUL OP_DIV
%token<ival> INTEIRO
%token PONTO_E_VIRGULA
//%token JOGO_DA_VELHA
//%token ESPACO
%token BARRA_N
//%token COMENTARIO

%left OP_SOM OP_SUB
%left OP_MUL OP_DIV

%type<sval> line
%type<sval> expressao
%type<ival> exp_mat
%type<sval> declaracao
%type<sval> atribuicao
%type<sval> impressao

%start prog

%%

prog: 
    | line
;

line: BARRA_N
    | expressao line                 
    | expressao BARRA_N      // {printf("Notação posfixa: %s\n", $1); free($1);}
;

expressao: expressao
    | declaracao
    | atribuicao
    | impressao
;

declaracao: VAR ID BARRA_N          {printf("Declaracao: %s", $2);}
;

atribuicao: ID OP_ATT ID
    | ID OP_ATT INTEIRO
    | ID OP_ATT exp_mat
;

impressao: PRINT ID
;

exp_mat: INTEIRO                   {asprintf(&$$, "%d", $1);}
    | exp_mat OP_SOM exp_mat       {asprintf(&$$, "%s %s +", $1, $3); free($1); free($3);}
    | exp_mat OP_SUB exp_mat       {asprintf(&$$, "%s %s -", $1, $3); free($1); free($3);}
    | exp_mat OP_MUL exp_mat       {asprintf(&$$, "%s %s *", $1, $3); free($1); free($3);}
    | exp_mat OP_DIV exp_mat       {asprintf(&$$, "%s %s /", $1, $3); free($1); free($3);}
;

%%

int main(){
    yyin = stdin;

    do {
        yyparse();
    }while(!feof(yyin));
    
    return 0;
}

void yyerror(const char* s){
    fprintf(stderr, "%s\n", s);
    exit(1);
}
