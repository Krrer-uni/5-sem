%code top {
  #include <assert.h>
  #include <ctype.h>  /* isdigit. */
  #include <stdio.h>  /* printf. */
  #include <stdlib.h> /* abort. */
  #include <string.h> /* strcmp. */
  #include "my_arithmetic.h"
  int yylex (void);
  void yyerror (char const *);
  extern int yy_flex_debug;
  void yyset_debug(int);
  const unsigned int gf_base = 1234577;
}

%define api.header.include {"calc_y.h"}



/* Generate YYSTYPE from the types used in %token and %type.  */
%define api.value.type union

%token <char> CHAR
%token  <long int> NUM "number"
%type  <long int> pow_expr
%type  <long int> expr
%left <long int> '+' '-'
%left <long int> '*' '/'
%precedence <long int> NEG
%precedence <long int> NUM_NEG
%right <long int> '^'


// %verbose
// %define parse.error detailed
// %define parse.trace
// %printer { fprintf (yyo, "%d", $$); } <long int>;

%% /* The grammar follows.  */
input:
  %empty
| input line
;

line:
  '\n'
| expr '\n'  { printf ("\nWynik: %ld\n", $1); }
| '#' commment '\n'
| error '\n' { yyerrok; }
;

expr:
  NUM { $$ = gfnorm($1,gf_base); printf("%ld ", $1); }
| expr '+' expr { $$ = gfadd($1, $3,gf_base); printf("+ "); }
| expr '-' expr { $$ = gfsub($1, $3,gf_base); printf("- "); }
| expr '*' expr { $$ = gfmul($1, $3,gf_base); printf("* "); }
| expr '/' expr { $$ = gfdiv($1, $3,gf_base); printf("/ "); }
| expr '^' pow_expr { $$ = gfpow($1, $3,gf_base); printf("^ "); }
| '-' expr %prec NEG { $$ = gfnorm(-$2,gf_base); }
| '(' expr ')' { $$ = $2; }
;

pow_expr:
  NUM { $$ = gfnorm($1,gf_base-1); printf("%ld ", $1); }
| pow_expr '+' pow_expr { $$ = gfadd($1, $3,gf_base-1); printf("+ "); }
| pow_expr '-' pow_expr { $$ = gfsub($1, $3,gf_base-1); printf("- "); }
| pow_expr '*' pow_expr { $$ = gfmul($1, $3,gf_base-1); printf("* "); }
| pow_expr '/' pow_expr { $$ = gfdiv($1, $3,gf_base-1); printf("/ "); }
| pow_expr '^' pow_expr { $$ = gfpow($1, $3,gf_base-1); printf("^ "); }
| '-' pow_expr %prec NEG { $$ = gfnorm(-$2,gf_base-1); }
| '(' pow_expr ')' { $$ = $2; }
;

commment:
 %empty
| '+' commment
| '-' commment
| '*' commment
| '/' commment
| '^' commment
| '(' commment
| ')' commment
| NUM commment
| CHAR commment
| '#' commment
;
%%

/* Called by yyparse on error.  */
void
yyerror (char const *s)
{
  fprintf (stderr, "%s\n", s);
}

int
main (int argc, char const* argv[])
{
  yyset_debug(0);
  /* Enable parse traces on option -p.  */
  // for (int i = 1; i < argc; ++i)
  //   if (!strcmp (argv[i], "-p"))
      
  return yyparse ();
}
 