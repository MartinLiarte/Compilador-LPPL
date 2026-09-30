%{
#include <stdio.h>
#include <string.h>
#include "header.h"
#include "asin.tab.h" /* Bison generará este fichero con los tokens*/

/* Función para imprimir las líneas si verbosidad es TRUE */

void imprime_linea(){
    if (verbosidad){
        fprintf(stdout, "3d.- ", yyylineno);
    }
}
%}

/*opciones de Flex*/
%option yyylineno
%option noyywrap

/* Definiciones regulares (macros) */
letra           [a-zA-Z]
digito          [0-9]
entero          {digito}+
real            {digito}+\.|{digito}*\.{digito}+
ident           {letra}({letra}|{digito}|"-")*
comentario      "//".*
delimitador     [ \t]

%%

{comentario}    { /* Ignorar los comentarios de una línea */ }
{delimitador}   { /* Ignorar espacios y tabuladores */ }

"\n"            { imprime_linea(); /* Al saltar de línea, imprimimos el prefijo si toca */ }

 /* Palabras reservadas (siempre en minúsculas) */
"true"          { return TRUE_; }
"false"         { return FALSE_; }
"int"           { return INT_; }
"bool"          { return BOOL_; }
"return"        { return RETURN_; }
"switch"        { return SWITCH_; }
"less"          { return LESS_; }
"equal"         { return EQUAL_; }
"greater"       { return GREATER_; }
"read"          { return READ_; }
"print"         { return PRINT_; }
"if"            { return IF_; }
"else"          { return ELSE_; }
"for"           { return FOR_; }

 /* Operadores de más de un carácter */
"&&"            { return AND_; }
"||"            { return OR_; }
"=="            { return IGUAL_; }
"!="            { return DISTINTO_; }
">="            { return MAYORIGUAL_; }
"<="            { return MENORIGUAL_; }

 /* Operadores y separadores de un solo carácter */
"+"|"-"|"*"|"/"|"!"|">"|"<"|"="|";"|","|"{"|"}"|"("|")"|"["|"]" { 
                  return yytext[0]; /* Devolvemos su código ASCII directamente */
                }

 /* Constantes y variables */
{entero}        { return CTE_; }
{real}          { return CTE_; /* El manual dice que se tratan como constantes numéricas */ }

{ident}         { return ID_; }

 /* Cualquier otro carácter es un error léxico */
.               { yyerror("Caracter desconocido"); }

%%