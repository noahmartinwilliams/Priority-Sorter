module Main where

import System.Directory
import System.IO
import Data.List.Split
import Data.Either
import System.Environment
import System.IO.Unsafe

compareGEIO :: Show a => a -> a -> IO Bool
compareGEIO a b = do
	putStrLn ("\n" ++ (show a) ++ ">=" ++ (show b) ++ " [y/Y/n/N] ? ") 
	l <- getLine 
	if l == "y" || l == "Y"
	then
		return True
	else if l == "n" || l == "N"
	then
		return False
	else
		compareGEIO a b

compareGE :: Show a => a -> a -> Bool
compareGE a b = unsafePerformIO (compareGEIO a b)

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
	if (length args) < 2 
	then
		putStrLn "Usage: Sorter input-file output-file"
	else do
		let (input : output : _) = args in do
			if (unsafePerformIO (doesFileExist input)) == False
			then
				putStrLn ("error: " ++ (show input) ++ " does not exist.") 
			else do
				i <- readFile input
				let lines = (endBy "\n" i) in
					writeFile output (foldr (\x -> \y -> x ++ "\n" ++ y) "" (sort lines))
