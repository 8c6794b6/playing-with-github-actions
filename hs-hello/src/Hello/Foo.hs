module Hello.Foo where

import           Control.Monad (when)

foo01 :: Int -> Int -> IO ()
foo01 a b = do
  when (a < 0 && b < 0) $
    putStrLn "a < 0 && b < 0"

  when (0 <= a && b < 0) $
    putStrLn "0 <= a && b < 0"

  when (a < 0 && 0 <= b) $
    putStrLn "a < 0 && 0 <= b"

  when (0 <= a && 0 <= b) $
    putStrLn "0 <= a && 0 <= b"
