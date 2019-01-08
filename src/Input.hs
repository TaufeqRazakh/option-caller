{-# LANGUAGE OverloadedStrings #-}

module Input where -- exporting only interactPage 

import Data.Text.IO as T
import Data.Text as T
import Control.Monad
import Data.List
import System.IO
import Data.Ord

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
          otherwise -> T.putStrLn "***invalid option***"

        inputRoutine
      
data Option = Option { symbol :: T.Text
                     , expiry :: LocalTime
                     , strike :: Double
                     , price  :: Double
                     } deriving(Show, Eq)

data Stock = Stock T.Text {-implement this Stock data format-}

data Portfolio = Portfolio { options :: [Option]
                           , stocks  :: [Stock]
                           }
                 
showPortfolio :: IO ()
showPortfolio = T.putStr "Empty Portfolio\n"

purchaseStock :: IO ()
purchaseStock = undefined 

purchaseOptions :: IO ()
purchaseOptions = undefined 

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