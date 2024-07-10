(** Abstract syntax. *)

(** Arithmetical exprs. *)
type expr =
  | Numeral of int (** non-negative integer constant *)
  | Plus of expr * expr  (** Addition [e1 + e2] *)
  | Minus of expr * expr (** Difference [e1 - e2] *)
  | Times of expr * expr (** Product [e1 * e2] *)
  | Divide of expr * expr (** Quotient [e1 / e2] *)
  | Negate of expr (** Opposite value [-e] *)


type exprs = expr list
(** Conversion of expresions to strings. *)
let string_of_expr e =
  let rec to_str n e =
    let (m, str) = match e with
	Numeral n       ->    (3, string_of_int n)
      | Negate e        ->    (2, "-" ^ (to_str 2 e))
      | Times (e1, e2)  ->    (1, (to_str 1 e1) ^ " * " ^ (to_str 2 e2))
      | Divide (e1, e2) ->    (1, (to_str 1 e1) ^ " / " ^ (to_str 2 e2))
      | Plus (e1, e2)   ->    (0, (to_str 0 e1) ^ " + " ^ (to_str 1 e2))
      | Minus (e1, e2)  ->    (0, (to_str 0 e1) ^ " - " ^ (to_str 1 e2))
    in
      if m < n then "(" ^ str ^ ")" else str
  in
    to_str (-1) e;;

(** Conversion of expresions to strings. *)

let string_of_exprs es = String.concat "\n" (List.map string_of_expr es)