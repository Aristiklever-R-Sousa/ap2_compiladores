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
var "var "[a-zA-Z][a-zA-Z0-9]*
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

{ESPACO}            {printf("ESPAÇO");}
{COMENTARIO}        {printf("COMENTÁRIO");}
{PRINT}             {printf("print");}
{BARRA_T}           {printf("\t");}
{BARRA_N}           {printf("\n");}
{res}               {printf("%s");}
{var}               {printf("[var]");}
{abre_chave}        {printf("[abre chaves]");}
{fecha_chave}       {printf("[fecha chaves]");}
{ponto_virgula}     {printf("[ponto_virgula]");}
{abre_parenteses}   {printf("[abre parenteses]");}
{fecha_parenteses}  {printf("[fecha parenteses]");}
{op_atrib}          {printf("[operador atribuição]");}

{integer}           {printf("[int]", yytext, yyleng);cont++;}
{float}             {printf("[float]", yytext, yyleng);cont++;}
{double}            {printf("[double]", yytext, yyleng);cont++;}
{op_mat}            {printf("[op_mat]", yytext);cont++;}
{op_rel}            {printf("[op_rel]", yytext);cont++;}

%%

int main() {
  yylex();
  // printf("\nQtd tokens = %d\n", cont);
  return 0;
}
