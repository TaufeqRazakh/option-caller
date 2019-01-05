module Main where

import Lib
import Store
import Input

main :: IO ()
main = do
    putStrLn "Welcome to the option-caller app"
    interactPage
    putStr $ "You have choosen to exit the app\n"