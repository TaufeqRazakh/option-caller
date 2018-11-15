{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( someFunc
    ) where

import Network.HTTP.Conduit (simpleHttp)
import Data.Aeson
import qualified Data.Text.Lazy.IO as T
import qualified Data.Text.Lazy.Encoding as T 
import Data.Maybe

jsonURL :: String -> String -> String -> String
jsonURL symbol interval key = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" ++
          symbol ++ "&interval=" ++ interval ++ "min&apikey=" ++ key
-- dont forgert to add show q for the time when passing a number and not demo key 

someFunc :: IO (Value)
someFunc = do
 val <-  T.readFile "./sample/full.json"
 return . fromJust . decode . T.encodeUtf8 $ val