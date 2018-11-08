{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where

import Network.Http.Simple
import Data.Time.LocalTime
import Data.Time.Clock
import Data.Map.Lazy 

someFunc :: IO ()
someFunc = putStrLn "someFunc"

jsonURL :: String
jsonURL = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=MSFT&interval=5min&apikey="

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