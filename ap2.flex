%{
  #include <stdio.h>
  int cont = 0;
  /*
    flex ap1.flex && gcc lex.yy.c -lfl
    clear && ./a.out < input.txt
  */
%}

ESPACO [ ]
COMENTARIO #[ a-zA-Z][a-zA-Z0-9]*
BARRA_T [\t]
BARRA_N [\n]
var var [a-zA-Z][a-zA-Z0-9]*
res ("if"|"else")

abre_chave ["{"]
ponto_virgula [;]
fecha_chave ["}"]
abre_parenteses ["("]
fecha_parenteses [")"]

integer [-+]?[0-9]+
double [-+]?[0-9]+\.[0-9]+
float [-+]?[0-9]+\.[0-9]{2}
op_mat (\+|-|\*|\/)
op_atrib (=)
op_rel (<|>)

%%

{ESPACO}            {printf(" ");}
{COMENTARIO}        {printf(" ");}
{BARRA_T}           {printf("\t");}
{BARRA_N}           {printf("\n");}
{res}               {printf("%s", yytext);cont++;}
{var}               {printf("[var %s]", yytext); cont++;}
{abre_chave}        {printf("[abre chaves]");}
{fecha_chave}       {printf("[fecha chaves]");}
{ponto_virgula}     {printf("[ponto_virgula]");}
{abre_parenteses}   {printf("[abre parenteses]");}
{fecha_parenteses}  {printf("[fecha parenteses]");}
{op_atrib}          {printf("[operador atribuição]");}

{integer}           {printf("[int %s]", yytext, yyleng);cont++;}
{float}             {printf("[float], %s, %d\n", yytext, yyleng);cont++;}
{double}            {printf("[double], %s, %d\n", yytext, yyleng);cont++;}
{op_mat}            {printf("[op_mat %s]", yytext);cont++;}
{op_rel}            {printf("[op_rel %s]", yytext);cont++;}

%%

int main() {
  yylex();
  // printf("\nQtd tokens = %d\n", cont);
  return 0;
}
