%{
  #include <stdio.h>

/*
  flex -o ap2.c ap2.flex && gcc -o ap2.out ap2.c -lfl && ./ap2.out < input.txt
*/
%}

VAR ("var")
PRINT ("print")
ID [a-zA-Z][a-zA-Z0-9]*
OPERADORES [*/=+-]
INTEIROS [-+]?[0-9]+
SIMBOLOS [;#]
ESPACO [ \t]
BARRA_N [\n]
COMENTARIO #.*


%%

{VAR}         {printf("VAR %s\n", yytext);}
{PRINT}       {printf("PRINT %s\n", yytext);}
{ID}          {printf("ID %s\n", yytext);}
{OPERADORES}  {printf("OPERADORES %s\n", yytext);}
{INTEIROS}    {printf("INTEIROS %s\n", yytext);}
{SIMBOLOS}    {printf("SIMBOLOS %s\n", yytext);}
{ESPACO}      {printf("ESPACO %s", yytext);}
{BARRA_N}      {printf("BARRA_N %s", yytext);}
{COMENTARIO}  {printf("COMENTARIO %s\n", yytext);}

%%

int main() {
  yylex();
  return 0;
}
