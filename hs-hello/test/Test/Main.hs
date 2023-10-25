module Test.Main where

import Hello.Foo

main :: IO ()
main = do
  foo01 (-1) 1
  foo01 1 (-1)
