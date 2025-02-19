(** Evaluation of exprs, given as big step semantics. *)

(** [eval e] evaluates the expr [e] to an integer. It raises an
    exception if division by zero occurs. *)
let rec eval = function
  | Syntax.Numeral n -> n
  | Syntax.Plus (e1, e2) -> eval e1 + eval e2
  | Syntax.Minus (e1, e2) -> eval e1 - eval e2
  | Syntax.Times (e1, e2) -> eval e1 * eval e2
  | Syntax.Divide (e1, e2) ->
      let n2 = eval e2 in
	if n2 <> 0 then eval e1 / n2 else raise Division_by_zero
  | Syntax.Negate e -> - (eval e)

let eval_exprs = List.map eval