%{
  #include <stdio.h>

/*
  flex -o ap2.c ap2.flex && gcc -o ap2.out ap2.c -lfl && ./ap2.out < input.txt
*/
%}

VAR ("var")
PRINT ("print")
ID [a-zA-Z][a-zA-Z0-9]*
OP_ATT [=]
OP_SOM [+]
OP_SUB [-]
OP_MUL [*]
OP_DIV [/]
INTEIRO [-+]?[0-9]+
PONTO_E_VIRGULA [;]
JOGO_DA_VELHA #
ESPACO [ \t]
BARRA_N [\n]
COMENTARIO #.*


%%

{VAR}                {printf("VAR %s\n", yytext);}
{PRINT}              {printf("PRINT %s\n", yytext);}
{ID}                 {printf("ID %s\n", yytext);}
{OP_ATT}             {printf("OP_ATT %s\n", yytext);}
{OP_SOM}             {printf("OP_SOM %s\n", yytext);}
{OP_SUB}             {printf("OP_SUB %s\n", yytext);}
{OP_MUL}             {printf("OP_MUL %s\n", yytext);}
{OP_DIV}             {printf("OP_DIV %s\n", yytext);}
{INTEIRO}            {printf("INTEIRO %s\n", yytext);}
{PONTO_E_VIRGULA}    {printf("PONTO_E_VIRGULA %s\n", yytext);}
{JOGO_DA_VELHA}      {printf("JOGO_DA_VELHA %s\n", yytext);}
{ESPACO}             {printf("ESPACO %s\n", yytext);}
{BARRA_N}            {printf("BARRA_N %s", yytext);}
{COMENTARIO}         {printf("COMENTARIO %s\n", yytext);}

%%

int main() {
  yylex();
  return 0;
}
