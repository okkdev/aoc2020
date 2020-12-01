-- test case
-- input :: [Int]
-- input =
--     [ 1721
--     , 979
--     , 366
--     , 299
--     , 675
--     , 1456
--     ]

input :: IO [Int]
input = do
  contents <- readFile "input.txt"
  let ints = map read . lines $ contents
  return ints

-- Rewrite target
targets :: [Int]
targets = map (2020 -) input

schloop :: [Int] -> Int
schloop (x:xs) = case filter (==x) targets of
    [n] -> n * (2020 - n)
    _   -> schloop xs

main :: IO ()
main = do
    list <- input
    print $ schloop list
