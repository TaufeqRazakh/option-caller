{-# LANGUAGE OverloadedStrings #-}

module Input where -- exporting only interactPage 

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
          otherwise -> T.putStrLn "***invalid option***"

        inputRoutine

retBasePortFolio = Portfolio { options = (Just Option {Types.Option.symbol = "MSFT", Types.Option.expiry = LocalTime { localDay = (read $ "2018-11-07"), localTimeOfDay = read $ "16:00:00"}, Types.Option.strike = 100, Types.Option.price = 10}), stocks = (Just Stock {Types.Stock.symbol = "MSFT", Types.Stock.value = 100, Types.Stock.price = 10} ) }

showPortfolio :: IO ()
showPortfolio = System.IO.putStr $ show retBasePortFolio

purchaseStock :: IO ()
purchaseStock = do
  T.putStrLn "Type in the symbol, and price of the stock"
  userInput <- T.getLine
  case (toStock userInput) of
    Right _ -> T.putStrLn "success!"
    Left msg -> T.putStrLn msg

purchaseOptions :: IO ()
purchaseOptions = do
  T.putStrLn "Type in the symbol, expiry date (yyyy-mm-dd), strike, and price of the option separated by space" 
  userInput <- T.getLine
  case (toOption userInput) of
    Right _ -> T.putStrLn "success!"
    Left (msg) -> T.putStrLn msg

-- TO REMOVE
sampleOption :: Option
sampleOption = Option "MSFT" LocalTime { localDay = (read $ "2018-11-07"), localTimeOfDay = (read $ "16:00:00")} 200 20

-- UPTO

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

-- REMOVE BELOW 
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
