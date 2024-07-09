let main () =
  let istream =
    if Array.length Sys.argv > 1 then open_in Sys.argv.(1) else stdin
  in
  let lexbuf = Lexing.from_channel istream in
  try
    while true do
      try
        let result_ast = Parser.toplevel Lexer.lexeme lexbuf in
        let result_val = Eval.eval result_ast in
        print_endline (Syntax.string_of_expression result_ast ^ " = " ^ string_of_int result_val);
      with
      | Parser.Error -> print_endline "parser err"; exit 1
    done
  with
  | End_of_file -> close_in istream; exit 0


let () = Printexc.record_backtrace true
let () = main ()