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

foo02 :: Int -> Int -> IO ()
foo02 a b
  | b == 0 = putStrLn "Cannot divide by zero."
  | otherwise = case quotRem a b of
      (q, 0) -> print q
      _      -> print (fromIntegral a / fromIntegral b :: Double)
