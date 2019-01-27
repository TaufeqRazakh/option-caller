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
class FromTextINput a where
  fromText :: T.Text -> a

instance FromTextInput Option where
  fromText inputText = let inputSet = T.words inputText
                       in case inputSet of
                            (symbol:xs) ->  
