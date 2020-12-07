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

let get_seat code range : int * int = 
  let deduct (low, high) = ((high - low) / 2) + low in
  let rec visit (low, high) = function
    | 'F' :: rem -> visit (low, deduct (low, high)) rem 
    | 'L' :: rem -> visit (low, deduct (low, high)) rem
    | 'B' :: rem -> visit (deduct (low, high), high) rem
    | 'R' :: rem -> visit (deduct (low, high), high) rem
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

let id_list list : int list =
  let rec visit list = function
    | x :: xs -> visit (((get_row x) * 8 + (get_column x)) :: list) xs
    | [] -> list in
  visit [] list

let find_missing min list =
  let rec find min = function
    | x :: xs when x > min -> min
    | x :: xs -> find (x + 1) xs
    | [] -> min in
  find min list

let () = 
  let codes = read_lines "input.txt" in
  let ids = List.sort compare (id_list codes) in
  printf "Missing ID: %i\n" (find_missing (List.hd ids) ids)