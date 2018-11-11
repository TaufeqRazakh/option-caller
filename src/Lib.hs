{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Lib
    ( someFunc
    ) where

import GHC.Generics
import Network.HTTP.Conduit (simpleHttp)
import Data.Time.LocalTime
import Data.Time.Clock
import Data.Aeson
import Data.Map.Lazy (Map, empty)
import qualified Data.ByteString.Lazy.Char8 as C

jsonURL :: String -> String -> String -> String
jsonURL symbol interval key = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" ++
          symbol ++ "&interval=" ++ interval ++ "min&apikey=" ++ key
-- dont forgert to add show q for the time when passing a number and not demo key 

someFunc :: IO ()
someFunc = do
 val <- C.readFile $ "./sample/textReacher.txt"
 C.putStr val