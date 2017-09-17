{-# LANGUAGE LambdaCase #-}

module Main where

import Data.List (intercalate, nubBy, sortBy)
import System.Directory
import System.Environment
import System.FilePath
import System.FilePath.Find
import System.IO

main :: IO ()
main = getArgs >>= \case
  [dir, ext] -> findLatest dir ext
  _          -> usage

findLatest :: FilePath -> String -> IO ()
findLatest dir ext = do
  files <- find (pure True) (extension ==? "." ++ ext) dir
  metas <- mapM meta files
  putStr $ (intercalate "\NUL" . map third . nubBy f . reverseSort) metas
  where
    f (_, n1, _) (_, n2, _) = n1 == n2
    third (_, _, x) = x
    reverseSort = sortBy (flip compare)  -- reverse . sort

meta f = do
  t <- getModificationTime f
  return (t, takeFileName f, f)

escape []       = []
escape (' ':cs) = '\\' : ' ' : escape cs
escape ( c :cs) =         c  : escape cs
-- quoteString s = '"' : mappend s "\""

usage = hPutStrLn stderr "Usage: findlatest DIR EXT"
