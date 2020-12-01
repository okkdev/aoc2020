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

createTargets :: [Int] -> [Int]
createTargets = map (2020 -)

schloop (x : xs) targets = case filter (== x) targets of
  [n] -> n * (2020 - n)
  _ -> schloop xs targets

main :: IO ()
main = do
  list <- input
  let targets = createTargets list
  print $ schloop list targets
