{-# LANGUAGE OverloadedStrings #-}

module SimpleRead where -- exporting only interactPage 

import qualified Data.ByteString.Lazy as B
import qualified Data.HashMap.Strict as HM
import qualified Data.Text as T
import Data.Vector hiding ((++), head)
import Network.HTTP.Conduit (simpleHttp)
import Data.Maybe
import Data.Aeson
import Types.Option
import Types.Stock
import Types.Portfolio
import Data.Time.LocalTime

jsonURL :: String -> String -> String -> String
jsonURL symbol interval key = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol="
  ++symbol ++ "&interval=" ++ interval ++ "min&apikey=" ++ key

retStr :: Value -> String
retStr (String x) = T.unpack x

retSym :: Value -> String
retSym (Object x) = retStr $ fromJust (HM.lookup ("2. Symbol") x)

retMet :: Value -> String 
retMet (Object x) = retSym $ fromJust (HM.lookup ("Meta Data") x)

someFunc :: IO (String)
someFunc = do
  samp <-  B.readFile "./sample/full.json"
  return (retMet $ fromJust $ decode $ samp)

decodeFunc :: IO (Value)
decodeFunc = do 
  samp <-  B.readFile "./sample/full.json"
  return $ fromJust $ decode $ samp

-- See how a sample Portfolio is declared

retBasePortfolio = Portfolio { options = (Just Option {Types.Option.symbol = "MSFT", Types.Option.expiry = LocalTime { localDay = (read $ "2018-11-07"), localTimeOfDay = read $ "16:00:00"}, Types.Option.strike = 100, Types.Option.price = 10}), stocks = (Just Stock {Types.Stock.symbol = "MSFT", Types.Stock.value = 100, Types.Stock.price = 10} ) }

--See how a sample Option is declared

sampleOption :: Option
sampleOption = Option "MSFT" LocalTime { localDay = (read $ "2018-11-07"), localTimeOfDay = (read $ "16:00:00")} 200 20
