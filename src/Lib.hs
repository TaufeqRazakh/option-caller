module Lib
    ( someFunc
    ) where

import qualified Data.ByteString.Lazy as B
import qualified Data.HashMap.Strict as HM
import qualified Data.Text as T
import Data.Vector hiding ((++), head)
import Network.HTTP.Conduit (simpleHttp)
import Data.Time.LocalTime
import Data.Maybe
import Data.Aeson

data MetaData = MetaData { information :: String
                         , symbol :: String
                         , lastRefreshed :: LocalTime
                         , interval :: String
                         , outputSize :: String
                         , timeZone :: TimeZone
                         } deriving (Show)

jsonURL :: String -> String -> String -> String
jsonURL symbol interval key = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol="
  ++symbol ++ "&interval=" ++ interval ++ "min&apikey=" ++ key

retStr :: Value -> String
retStr (String x) = T.unpack x

retSym :: Value -> String
retSym (Object x) = retStr (fromJust (HM.lookup (T.pack "2. Symbol") x))

retMet :: Value -> String 
retMet (Object x) = retSym (fromJust (HM.lookup (T.pack "MetaData") x))

someFunc :: IO (String)
someFunc = do
  samp <-  B.readFile "./sample/full.json"
  return (retMet $ fromJust $ decode $ samp)

