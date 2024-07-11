%{
%}

/* Lexemes */
%token <int> NUMERAL
%token PLUS
%token MINUS
%token TIMES
%token DIVIDE
%token UMINUS
%token LPAREN
%token RPAREN
%token EOF
%token NEWLINE

/* Precedence and associativity */
%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

/* Top level rule */
%start toplevel
%type <Syntax.exprs> toplevel

%%

/* Grammar */

toplevel:
    | es = exprs EOF { es }
; 

expr:
  | n = NUMERAL                 { Syntax.Numeral n }
  | e1 = expr TIMES  e2 = expr  { Syntax.Times (e1, e2) }
  | e1 = expr PLUS   e2 = expr  { Syntax.Plus (e1, e2) }
  | e1 = expr MINUS  e2 = expr  { Syntax.Minus (e1, e2) }
  | e1 = expr DIVIDE e2 = expr  { Syntax.Divide (e1, e2) }
  | MINUS e = expr %prec UMINUS       { Syntax.Negate e }
  | LPAREN e = expr RPAREN            { e }
;

exprs:
    | e = expr { [e] }
    | es = exprs NEWLINE e = expr { es @ [e] }
;
