{-# LANGUAGE OverloadedStrings #-}

module Input where -- exporting only interactPage 

import System.IO
import Data.Text.IO as T
import Data.Text as T
import Data.Ord
import Control.Monad
import Data.List

options2 :: IO ()
options2 = do
    let lOptions = ["q -- quit this program"
                   , "h -- list of possible moves and inputs"
                   , "v -- view current portfolio"
                   , "a -- purchase stock volumes"
                   , "o -- purchase options"
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
    T.putStr $ "give me a symbol: " 
    line <- T.getLine 
    unless (line == "q") $ do
        T.putStrLn $ "okay i'll fetch stocks for " `T.append` line
        inputRoutine

interactPage :: IO ()
interactPage = do
    options2
    inputRoutine 
    
takeOwnedSymbol :: IO [Text]
takeOwnedSymbol = do
  print $ "Type in a symbol for which you own stocks, the volume, the value purchased for \n (Use comma and space as separator)"
  sym <- T.getLine
  let sp = T.splitOn (T.pack ", ") sym
  return sp 

takeOptionSymbol :: IO [Text]
takeOptionSymbol = do
    print $ "Type in a symbol for which you own options, validity date YYYY-MM-DD, the option price \n (Use comma and space as separator)"
    sym <- T.getLine
    let sp = T.splitOn (T.pack ", ") sym
    return sp 