{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( someFunc
    ) where

import GHC.Generics
import Network.HTTP.Simple
import Data.Time.LocalTime
import Data.Time.Clock
import Data.Aeson
import Data.Map.Lazy (Map, empty)
import qualified Data.ByteString as B

jsonURL symbol interval key :: String -> String -> String -> String
jsonURL = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" ++ symbol ++"&interval=" ++ interval ++ "min&apikey=" ++ key
-- dont forgert to add show q for the time when passing a number and not demo key

data AlphaMetaData = AlphaMetaData { information :: String
                                   , symbol :: String
                                   , lastRefreshed :: LocalTime
                                   , interval :: String
                                   , outputSize :: String
                                   } deriving (Generic, Show)

instance ToJSON AlphaMetaData 
instance FromJSON AlphaMetaData where
    parseJSON = withObject "AlphaMetaData" $ \amd -> AlphaMetaData
        <$> amd .: "1. Information"
        <*> amd .: "2. Symbol"
        <*> amd .: "3. Last Refreshed"
        <*> amd .: "4. Interval"
        <*> amd .: "5. Output Size"

data Tick = Tick { open :: Double
                 , high :: Double
                 , low :: Double
                 , close :: Double
                 , volume :: Int
                 } deriving (Generic, Show)

instance ToJSON Tick
instance FromJSON Tick where
     parseJSON = withObject "Tick" $ \tick -> Tick
        <$> tick .: "1. open"
        <*> tick .: "2. high"
        <*> tick .: "3. low"
        <*> tick .: "4. close"
        <*> tick .: "5. volume"

data TimeSeriesResponse = TimeSeriesResponse { metaData :: AlphaMetaData
                                             , ticks :: Map UTCTime Tick
                                             } deriving (Generic, Show)

instance ToJSON TimeSeriesResponse 
instance FromJSON TimeSeriesResponse where
     parseJSON = withObject "TimeSeriesResponse" $ \tsr -> TimeSeriesResponse
        <$> tsr .: "Meta Data"
        <.> tsr .: "Time Series (5min)" 

decodeTimeSeriesResponse :: IO (Maybe TimeSeriesResponse)
decodeTimeSeriesResponse = do 
    response <- fmap decode $ simpleHttp $ jsonURL "MSFT" "5" "demo" 
    return response

obtainedTimeSeriesResponse :: IO (Maybe TimeSeriesResponse)
obtainedTimeSeriesResponse = do 
    preResponse <- B.readFile "sample/justTicks.json"
    response <- fmap decode preResponse  
