{-# LANGUAGE OverloadedStrings #-}

module Lib where

import Data.Text.IO as T
import Data.Text as T
import Control.Monad
import Data.List
import System.IO
import Data.Ord
import Types.Stock
import Types.Option 
import Types.Portfolio
import Types.Parser

import Data.Time.LocalTime

optionsMenu :: IO ()
optionsMenu = do
    let lOptions = [ "q -- quit this program"
                   , "h -- list of possible moves and inputs"
                   , "v -- view current portfolio"
                   , "a -- purchase stock volumes"
                   , "p -- purchase options"
                   , "c -- check status if option can be exercised"
                   , "r -- check status if stock volumes are to be sold"
                   , "s -- manually sell a stock you own"
                   , "e -- manually exercise an option"
                   ]  :: [Text]
    let width = T.length (maximumBy (comparing T.length) lOptions) :: Int
    displayWithEqualSpacing lOptions width
    where 
        displayWithEqualSpacing :: [T.Text] -> Int -> IO ()
        displayWithEqualSpacing (opt1 : opt2 : rest) width = do 
            T.putStrLn $ opt1 `T.append` (T.replicate (width-(T.length opt1)) " ") `append` "\t" `T.append` opt2
            displayWithEqualSpacing rest width
        displayWithEqualSpacing (opt : []) _ = T.putStrLn opt
                
inputRoutine :: IO ()
inputRoutine = do
    T.putStr $ "type in choice : " 
    line <- T.getLine 
    unless (line == "q") $ do
        case line of 
          "h" -> optionsMenu
          "v" -> showPortfolio
          "a" -> purchaseStock
          "p" -> purchaseOptions
          "c" -> checkStatusOption
          "r" -> checkStatusStock
          "s" -> sellStock
          "e" -> exerciseOption
          otherwise -> T.putStrLn "eeek...was that so hard to type?"

        inputRoutine

showPortfolio :: IO ()
showPortfolio = undefined

purchaseStock :: IO ()
purchaseStock = do
  T.putStrLn "Type in the symbol, and price of the stock"
  userInput <- T.getLine
  case (toStock userInput) of
    Right acceptedOption -> T.putStrLn $ T.pack $ show acceptedOption
    Left msg -> T.putStrLn msg

purchaseOptions :: IO ()
purchaseOptions = do
  T.putStrLn "Type in the symbol, expiry date (yyyy-mm-dd), strike, and price of the option separated by space" 
  userInput <- T.getLine
  case (toOption userInput) of
    Right _ -> T.putStrLn "Yeah Gucci Bro!"
    Left (msg) -> T.putStrLn msg

checkStatusOption :: IO ()
checkStatusOption = undefined

checkStatusStock :: IO ()
checkStatusStock = undefined

sellStock :: IO ()
sellStock = undefined

exerciseOption :: IO ()
exerciseOption = undefined

interactPage :: IO ()
interactPage = do
    optionsMenu
    inputRoutine
    T.putStrLn "So long Folks!"
