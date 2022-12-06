//
// Created by krrer on 06.12.22.
//
#include "calc_y.h"

int main (int argc, char const* argv[]){
  yyset_debug(0);
  return yyparse ();
}