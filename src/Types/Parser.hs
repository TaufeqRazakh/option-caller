{-# Language OverloadedStrings #-}
module Types.Parser where

import Types.Option
import Types.Stock
import Types.Portfolio

import Data.Time.LocalTime
import Data.Text as T

class FromTextInput a where
  toOption :: a -> Either T.Text Option
  toStock  :: a -> Either T.Text Stock

instance FromTextInput T.Text where
  toOption inputText = let inputSet = T.words inputText
                       in case inputSet of 
                            [] -> Left "insufficient input params"
                            (symbol_:toTime) -> case toTime of
                              [] -> Left "insufficient input params"
                              (_:[]) -> Left "insufficient input params"
                              (expiryDay_:expiryTime_:toStrike) -> case toStrike of
                                [] -> Left "insufficient input params"
                                (strike_ :toPrice) -> case toPrice of
                                  [] -> Left "insufficient input params"
                                  (price_:rest) -> Right Option { Types.Option.symbol = symbol_
                                                                , Types.Option.expiry = LocalTime (read $ T.unpack expiryDay_) (read $ T.unpack expiryTime_)
                                                                , Types.Option.strike = read (T.unpack strike_)
                                                                , Types.Option.price = read (T.unpack price_)
                                                                }

  toStock inputText = let inputSet = T.words inputText
                      in case inputSet of
                           [] -> Left "insufficient input params"
                           (symbol_:toValue) -> case toValue of
                             [] -> Left "insufficient input params"
                             (value_:toPrice) -> case toPrice of
                               [] -> Left "insufficient input params"
                               (price_:rest) -> Right Stock { Types.Stock.symbol = symbol_
                                                            , Types.Stock.value  = read (T.unpack value_)
                                                            , Types.Stock.price  = read (T.unpack price_)
                                                            }
