module Test.Main where

import           Hello.Foo

main :: IO ()
main = do
  foo01 (-1) 1
  foo01 1 (-1)
  --
  foo02 4 3
  foo02 4 2
  foo02 4 0
