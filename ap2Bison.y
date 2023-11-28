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

%token<ival> INTEIRO
%token OP_SUM OP_SUB OP_MUL OP_DIV
%token T_NEWLINE

%left OP_SUM OP_SUB
%left OP_MUL OP_DIV

%type<sval> exp

%start calc

%%

calc: 
    | calc line
;

line: T_NEWLINE                 
    | exp T_NEWLINE      {printf("Notação posfixa: %s\n", $1); free($1);}
;

exp: INTEIRO               {asprintf(&$$, "%d", $1);}
   | exp OP_SUM exp       {asprintf(&$$, "%s %s +", $1, $3); free($1); free($3);}
   | exp OP_SUB exp       {asprintf(&$$, "%s %s -", $1, $3); free($1); free($3);}
   | exp OP_MUL exp       {asprintf(&$$, "%s %s *", $1, $3); free($1); free($3);}
   | exp OP_DIV exp       {asprintf(&$$, "%s %s /", $1, $3); free($1); free($3);}
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
