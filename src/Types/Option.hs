{-# LANGUAGE OverloadedStrings #-}
module Types.Option where

import Data.Text as T
import Data.Time.LocalTime

data Option = Option { symbol :: T.Text
                     , expiry :: LocalTime
                     , strike :: Double
                     , price  :: Double
                     } deriving(Read, Show, Eq, Ord)

-- Move typeclass to it's own folder
class FromTextInput a where
  fromText :: T.Text -> Either T.Text a

instance FromTextInput Option where
  fromText inputText = let inputSet = T.words inputText
                       in case inputSet of
                            [] -> Left "Insufficient input"
                            (symbol:toTime) -> case toTime of
                              [] -> Left "insufficient input params"
                              (_:[]) -> Left "insufficient input params"
                              (expiryDay : expiryTime : toStrike) -> case toStrike of
                                [] -> Left "insufficient input params"
                                (strike : toPrice) -> case toPrice of
                                  [] -> Left "insufficient input params"
                                  (price:rest) -> Left "good job"
                              
