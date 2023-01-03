
# parsetab.py
# This file is automatically generated. Do not edit.
# pylint: disable=W,C,R
_tabversion = '3.10'

_lr_method = 'LALR'

_lr_signature = "left+-left*/rightUMINUSright^COMMENT NUMBERstatement : expressionexpression : expression '+' expression\n                  | expression '-' expression\n                  | expression '*' expression\n                  | expression '/' expression\n                  | expression '^' pow_exp expression : '-' expression %prec UMINUSexpression : '(' expression ')'expression : numberpow_exp : pow_exp '+' pow_exp\n                  | pow_exp '-' pow_exp\n                  | pow_exp '*' pow_exp\n                  | pow_exp '/' pow_exppow_exp : '-' pow_exp %prec UMINUSpow_exp : '(' pow_exp ')'pow_exp : numbernumber   : '-' NUMBER %prec UMINUS\n                | NUMBER"
    
_lr_action_items = {'-':([0,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,],[3,8,3,3,-9,-18,3,3,3,3,20,-7,-17,8,-2,-3,-4,-5,-6,20,20,-16,-8,20,20,20,20,-14,25,-10,-11,-12,-13,-15,]),'(':([0,3,4,7,8,9,10,11,20,21,24,25,26,27,],[4,4,4,4,4,4,4,21,21,21,21,21,21,21,]),'NUMBER':([0,3,4,7,8,9,10,11,20,21,24,25,26,27,],[6,13,6,6,6,6,6,6,13,6,6,6,6,6,]),'$end':([1,2,5,6,12,13,15,16,17,18,19,22,23,28,30,31,32,33,34,],[0,-1,-9,-18,-7,-17,-2,-3,-4,-5,-6,-16,-8,-14,-10,-11,-12,-13,-15,]),'+':([2,5,6,12,13,14,15,16,17,18,19,22,23,28,29,30,31,32,33,34,],[7,-9,-18,-7,-17,7,-2,-3,-4,-5,-6,-16,-8,-14,24,-10,-11,-12,-13,-15,]),'*':([2,5,6,12,13,14,15,16,17,18,19,22,23,28,29,30,31,32,33,34,],[9,-9,-18,-7,-17,9,9,9,-4,-5,-6,-16,-8,-14,26,26,26,-12,-13,-15,]),'/':([2,5,6,12,13,14,15,16,17,18,19,22,23,28,29,30,31,32,33,34,],[10,-9,-18,-7,-17,10,10,10,-4,-5,-6,-16,-8,-14,27,27,27,-12,-13,-15,]),'^':([2,5,6,12,13,14,15,16,17,18,19,22,23,28,30,31,32,33,34,],[11,-9,-18,11,-17,11,11,11,11,11,-6,-16,-8,-14,-10,-11,-12,-13,-15,]),')':([5,6,12,13,14,15,16,17,18,19,22,23,28,29,30,31,32,33,34,],[-9,-18,-7,-17,23,-2,-3,-4,-5,-6,-16,-8,-14,34,-10,-11,-12,-13,-15,]),}

_lr_action = {}
for _k, _v in _lr_action_items.items():
   for _x,_y in zip(_v[0],_v[1]):
      if not _x in _lr_action:  _lr_action[_x] = {}
      _lr_action[_x][_k] = _y
del _lr_action_items

_lr_goto_items = {'statement':([0,],[1,]),'expression':([0,3,4,7,8,9,10,],[2,12,14,15,16,17,18,]),'number':([0,3,4,7,8,9,10,11,20,21,24,25,26,27,],[5,5,5,5,5,5,5,22,22,22,22,22,22,22,]),'pow_exp':([11,20,21,24,25,26,27,],[19,28,29,30,31,32,33,]),}

_lr_goto = {}
for _k, _v in _lr_goto_items.items():
   for _x, _y in zip(_v[0], _v[1]):
       if not _x in _lr_goto: _lr_goto[_x] = {}
       _lr_goto[_x][_k] = _y
del _lr_goto_items
_lr_productions = [
  ("S' -> statement","S'",1,None,None,None),
  ('statement -> expression','statement',1,'p_statement_expr','example.py',92),
  ('expression -> expression + expression','expression',3,'p_expression_binop','example.py',99),
  ('expression -> expression - expression','expression',3,'p_expression_binop','example.py',100),
  ('expression -> expression * expression','expression',3,'p_expression_binop','example.py',101),
  ('expression -> expression / expression','expression',3,'p_expression_binop','example.py',102),
  ('expression -> expression ^ pow_exp','expression',3,'p_expression_binop','example.py',103),
  ('expression -> - expression','expression',2,'p_expression_uminus','example.py',123),
  ('expression -> ( expression )','expression',3,'p_expression_group','example.py',128),
  ('expression -> number','expression',1,'p_expression_number','example.py',133),
  ('pow_exp -> pow_exp + pow_exp','pow_exp',3,'p_pow_exp_binop','example.py',140),
  ('pow_exp -> pow_exp - pow_exp','pow_exp',3,'p_pow_exp_binop','example.py',141),
  ('pow_exp -> pow_exp * pow_exp','pow_exp',3,'p_pow_exp_binop','example.py',142),
  ('pow_exp -> pow_exp / pow_exp','pow_exp',3,'p_pow_exp_binop','example.py',143),
  ('pow_exp -> - pow_exp','pow_exp',2,'p_pow_exp_uminus','example.py',163),
  ('pow_exp -> ( pow_exp )','pow_exp',3,'p_pow_exp_group','example.py',168),
  ('pow_exp -> number','pow_exp',1,'p_pow_exp_number','example.py',173),
  ('number -> - NUMBER','number',2,'p_number','example.py',181),
  ('number -> NUMBER','number',1,'p_number','example.py',182),
]