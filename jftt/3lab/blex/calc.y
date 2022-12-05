%code top {
  #include <assert.h>
  #include <ctype.h>  /* isdigit. */
  #include <stdio.h>  /* printf. */
  #include <stdlib.h> /* abort. */
  #include <string.h> /* strcmp. */
  #include "my_arithmetic.h"
  int yylex (void);
  void yyerror (char const *);
}

%define api.header.include {"calc_y.h"}



/* Generate YYSTYPE from the types used in %token and %type.  */
%define api.value.type union
%token  <int> NUM "number"
%type  <int> expr
%left <int> '+' '-'
%left <int> '*' '/'
%precedence <int> NEG
%right <int> '^'

/* Generate the parser description file (calc.output).  */
%verbose

/* Nice error messages with details. */
%define parse.error detailed

/* Enable run-time traces (yydebug).  */
%define parse.trace

/* Formatting semantic values in debug traces.  */
%printer { fprintf (yyo, "%d", $$); } <int>;

%% /* The grammar follows.  */
input:
  %empty
| input line
;

line:
  '\n'
| expr '\n'  { printf ("%d/n", $1); }
| error '\n' { yyerrok; }
;

expr:
  NUM
| expr '+' expr { $$ = $1 + $3; }
| expr '-' expr { $$ = $1 - $3; }
| expr '*' expr { $$ = $1 * $3; }
| expr '/' expr { $$ = $1 / $3; }
| expr '^' expr { $$ = gpow($1 , $3); }
| '-' expr %prec NEG { $$ = -$2; }
| '(' expr ')' {$$ = $2;}
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
  /* Enable parse traces on option -p.  */
  for (int i = 1; i < argc; ++i)
    if (!strcmp (argv[i], "-p"))
      yydebug = 1;
  return yyparse ();
}