/*
flex -o ap2.c ap2.flex
*/
%{
  #include <stdio.h>
  int cont = 0;
  /*
    flex ap2.flex && gcc lex.yy.c -lfl &&
    clear && ./a.out < input.txt

    flex ap2.flex && gcc lex.yy.c -lfl && ./a.out < input.txt
  */
%}

VAR ["var"]
PRINT ["print"]
ID [a-zA-Z][a-zA-Z0-9]*
OPERADORES (=+-*\/)
INTEIROS [-+]?[0-9]+
SIMBOLOS [;#]
ESPACO [ \t\n]
COMENTARIO #.*


%%

{VAR}         {printf("%s", yytext);}
{PRINT}       {printf("%s", yytext);}
{ID}          {printf("%s", yytext);}
{OPERADORES}  {printf("%s", yytext);}
{INTEIROS}    {printf("%s", yytext);}
{SIMBOLOS}    {printf("%s", yytext);}
{ESPACO}      {printf("%s", yytext);}
{COMENTARIO}  {printf("%s", yytext);}

%%

int main() {
  yylex();
  return 0;
}
