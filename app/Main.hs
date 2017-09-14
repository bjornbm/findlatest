module Main where

import Lib
import Data.List (intercalate, nubBy, sort)
import System.Directory
import System.Environment
import System.FilePath
import System.FilePath.Find

main :: IO ()
main = do
  [dir] <- getArgs
  -- print dir
  files <- find (pure True) (extension ==? ".tcl") dir
  metas <- mapM meta files
  -- putStrLn . unwords $ (map (escape . third) . nubBy f . sort) metas
  putStr $ (intercalate "\NUL" . map third . nubBy f . reverse . sort) metas
  -- mapM_  print $ (map third . nubBy f . sort) metas
  where
    f (_, n1, _) (_, n2, _) = n1 == n2
    third (_, _, x) = x

meta f = do
  t <- getModificationTime f
  return (t, takeFileName f, f)

escape []       = []
escape (' ':cs) = '\\' : ' ' : escape cs
escape ( c :cs) =         c  : escape cs
-- quoteString s = '"' : mappend s "\""
