let print_expr_and_vals = function
  | (v, e) -> Printf.printf "%s = %d\n" (Syntax.string_of_expr e) v

let main () =
  let istream =
    if Array.length Sys.argv > 1 then open_in Sys.argv.(1) else stdin
  in
  let lexbuf = Lexing.from_channel istream in
  let result_exprs = Parser.toplevel Lexer.lexeme lexbuf in
  let result_vals = Eval.eval_exprs result_exprs in
  List.map print_expr_and_vals (List.combine result_vals result_exprs)
;;


let () = Printexc.record_backtrace true
let () = main ()