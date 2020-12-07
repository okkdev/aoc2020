open Printf

let read_lines name : string list =
  let ic = open_in name in
  let try_read () =
    try Some (input_line ic) with End_of_file -> None in
  let rec loop acc = match try_read () with
    | Some s -> loop (s :: acc)
    | None -> close_in ic; List.rev acc in
  loop []

let string_to_list s : char list =
  List.init (String.length s) (String.get s)

let max = function
  | [] -> invalid_arg "empty list"
  | x::xs -> List.fold_left max x xs

let get_seat code range : int * int = 
  let deduct (low, high) = (high + low) / 2 in
  let rec visit (low, high) = function
    | x :: rem when x = 'F' || x = 'L' -> visit (low, deduct (low, high)) rem
    | x :: rem when x = 'B' || x = 'R' -> visit (deduct (low, high), high) rem
    | x :: rem -> visit (low, high) rem
    | [] -> (low, high) in
  visit range code

let get_row code : int =
  let rowCode = string_to_list (String.sub code 0 7) in
  let (_, row) = get_seat rowCode (0, 127) in
  row

let get_column code : int =
  let columnCode = string_to_list (String.sub code 7 3) in
  let (_, column) = get_seat columnCode (0, 7) in
  column

let rec id_list list = function
  | x :: xs -> id_list (((get_row x) * 8 + (get_column x)) :: list) xs
  | [] -> list

let () = 
  let codes = read_lines "input.txt" in
  printf "Highest ID: %i\n" (max (id_list [] codes))