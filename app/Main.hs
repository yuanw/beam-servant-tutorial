module Main where

import           API                      (app1)
import           Network.Wai.Handler.Warp (run)

main :: IO ()
main = run 8081 app1
