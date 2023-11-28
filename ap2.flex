%{
  #include <stdio.h>
  int cont = 0;
  /*
    flex ap2.flex && gcc lex.yy.c -lfl
    clear && ./a.out < input.txt
  */
%}

ESPACO [ ]
COMENTARIO #.*
BARRA_T [\t]
BARRA_N [\n]
PRINT ("print")
var [a-zA-Z][a-zA-Z0-9]*

ponto_virgula [;]

integer [-+]?[0-9]+
float [-+]?[0-9]+\.[0-9]{2}
op_mat (\+|-|\*|\/)
op_atrib (=)

%%

{ESPACO}            {printf("ESPAÇO");}
{COMENTARIO}        {printf("COMENTÁRIO");}
{PRINT}             {printf("print");}
{BARRA_T}           {printf("\t");}
{BARRA_N}           {printf("\n");}
{var}               {printf("[var]");}
{ponto_virgula}     {printf("[ponto_virgula]");}
{op_atrib}          {printf("[operador atribuição]");}

{integer}           {printf("[int]", yytext, yyleng);cont++;}
{float}             {printf("[float]", yytext, yyleng);cont++;}
{op_mat}            {printf("[op_mat]", yytext);cont++;}
{op_rel}            {printf("[op_rel]", yytext);cont++;}

%%

int main() {
  yylex();
  // printf("\nQtd tokens = %d\n", cont);
  return 0;
}
