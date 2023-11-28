/*
flex -o ap2.c ap2.flex
*/
%{
  #include <stdio.h>

  /*
    flex ap2.flex && gcc lex.yy.c -lfl &&
    clear && ./a.out < input.txt

    flex ap2.flex && gcc lex.yy.c -lfl && ./a.out < input.txt
  */
%}

VAR ("var")
PRINT ("print")
ID [a-zA-Z][a-zA-Z0-9]*
OPERADORES [*/=+-]
INTEIROS [-+]?[0-9]+
SIMBOLOS [;#]
ESPACO [ \t]
BARRA_N[\n]
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
