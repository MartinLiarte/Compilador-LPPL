%{
#include <stdio.h>
#include "header.h"
extern int yylex(); /* Para que Bison sepa que Flex le va a dar los tokens */
extern void yyerror(const char * msg); /* Declarada en tu principal.c */
%}

/* Declaración de todos los tokens del lenguaje MenosC */
%token INT_ BOOL_ TRUE_ FALSE_ RETURN_ SWITCH_ LESS_ EQUAL_ GREATER_
%token READ_ PRINT_ IF_ ELSE_ FOR_ 
%token AND_ OR_ IGUAL_ DISTINTO_ MAYORIGUAL_ MENORIGUAL_
%token ID_ CTE_

%%
programa 
    : listDecla 
    ;

listDecla 
    : decla 
    | listDecla decla 
    ;
    
/* ... seguir copiando las reglas ... */
%%