%code top {
  #include <assert.h>
  #include <ctype.h>  /* isdigit. */
  #include <stdio.h>  /* printf. */
  #include <stdlib.h> /* abort. */
  #include <string.h> /* strcmp. */
  #include <string>
  #include <iostream>
  #include <numeric>
  #include "my_arithmetic.hh"
  #define OUTPUT_BUFFER 1000
  int yylex (void);
  void yyerror (char const *);
  extern int yy_flex_debug;
  void yyset_debug(int);
  std::string output;
  const unsigned int gf_base = 1234577;
  bool error_flag = false;
}

%define api.header.include {"calc_y.hh"}



/* Generate YYSTYPE from the types used in %token and %type.  */
%define api.value.type union

%token <char> CHAR
%token  <long int> NUM "number"
%type  <long int> pow_expr num expr
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
| expr '\n'  { printf ("%s\nWynik: %ld\n",output.c_str(), $1); output.erase();}
| '#' commment '\n'
| error '\n' { if(!error_flag){std::cout << "Błąd\n";}; error_flag = false;}
;

expr:
  num { $$ = gfnorm($1,gf_base); output.append(std::to_string(gfnorm($1,gf_base)) + " ");}
| expr '+' expr { $$ = gfadd($1, $3,gf_base); output.append(("+ ")); }
| expr '-' expr { $$ = gfsub($1, $3,gf_base); output.append(("- ")); }
| expr '*' expr { $$ = gfmul($1, $3,gf_base); output.append(("* ")); }
| expr '/' expr { $$ = gfdiv($1, $3,gf_base); output.append(("/ ")); 
   if($3 == 0)
      {std::cout << "0 nie ma elementu odwrotnego w grupie GF(1234577)\n"; YYERROR; yyclearin ;output.erase(); error_flag = true;}}
| expr '^' pow_expr { $$ = gfpow($1, $3,gf_base); output.append(("^ ")); }
| '(' expr ')' { $$ = $2; }
;

pow_expr:
  num { $$ = gfnorm($1,gf_base-1); output.append(std::to_string(gfnorm($1,gf_base-1)) + " ");}
| pow_expr '+' pow_expr { $$ = gfadd($1, $3,gf_base-1); output.append(("+ ")); }
| pow_expr '-' pow_expr { $$ = gfsub($1, $3,gf_base-1); output.append(("- ")); }
| pow_expr '*' pow_expr { $$ = gfmul($1, $3,gf_base-1); output.append(("* ")); }
| pow_expr '/' pow_expr { $$ = gfdiv($1, $3,gf_base-1); output.append(("/ ")); 
    if(std::gcd($1,$3) != 0)
      {std::cout << "0 nie ma elementu odwrotnego w grupie GF(1234576)\n"; YYERROR; output.erase(); error_flag = true;}}
| pow_expr '^' pow_expr { $$ = gfpow($1, $3,gf_base-1); output.append(("^ ")); }
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

num:
  NUM {$$ = $1;}
| '-' NUM %prec NEG {$$ = -$2;}
; 
%%

/* Called by yyparse on error.  */
void
yyerror (char const *s)
{
  // fprintf (stderr, "%s\n", s);
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
 