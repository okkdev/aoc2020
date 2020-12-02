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

schloop :: (Num a, Eq a) => [a] -> [a] -> [a] -> a
schloop [] _ results = product results
schloop (x : xs) targets results = case filter (== x) targets of
  [n] -> schloop xs targets $ n : results
  _   -> schloop xs targets results

main :: IO ()
main = do
  list <- input
  let targets = createTargets list
  print $ schloop list targets []
