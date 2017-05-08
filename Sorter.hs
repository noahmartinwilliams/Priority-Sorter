module Main where

import System.IO
import Data.List.Split
import Data.Either
import System.Environment
import System.IO.Unsafe

compareGE :: Show a => a -> a -> Bool
compareGE a b = unsafePerformIO (do putStrLn ("\n" ++ (show a) ++ " >= " ++ (show b) ++ " ? ") ; l <- getLine ; if l == "y" || l == "Y" then return True else return False)

filter2 :: (a -> Bool) -> [a] -> ([a], [a])
filter2 func list = let divided tmp = if func tmp then Left tmp else Right tmp in
	let mapped = map divided list in
		(lefts mapped, rights mapped)

sort :: Show a => Ord a => [a] -> [a]
sort [] = []
sort [a] = [a]
sort (first : rest) = let (left, right) = filter2 (\x -> compareGE x first) rest in
	let front = sort left in
		(front ++ [first] ++ (sort right))

main :: IO()
main = do
	args <- getArgs
	let (input : output : _) = args in do
		i <- readFile input
		let lines = (endBy "\n" i) in
			writeFile output (foldr (\x -> \y -> x ++ "\n" ++ y) "" (sort lines))
