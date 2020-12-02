input :: IO [Int]
input = do
  contents <- readFile "input.txt"
  let ints = map read . lines $ contents
  return ints

createTargets :: [Int] -> [Int]
createTargets = map (2020 -)

createTargets3 :: [Int] -> [Int] -> [[Int]] -> [Int]
createTargets3 [] _ result = concat result
createTargets3 (x : xs) list result = createTargets3 xs list $ map (x -) list : result

schloop :: (Num a, Eq a) => [a] -> [a] -> [a] -> a
schloop [] _ results = product results
schloop (x : xs) targets results = case filter (== x) targets of
  (n : _) -> schloop xs targets $ n : results
  _       -> schloop xs targets results

main :: IO ()
main = do
  list <- input
  let targets = createTargets list
  let targets3 = createTargets3 targets list []
  print $ schloop list targets3 []
