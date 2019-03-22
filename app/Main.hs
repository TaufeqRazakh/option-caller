module Main where

import Lib
import Store

main :: IO ()
main = do
    putStrLn "Welcome to the option-caller app\nBelow is a list of options you can invoke"
    interactPage
