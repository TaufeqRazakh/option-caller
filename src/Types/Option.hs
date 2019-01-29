{-# LANGUAGE OverloadedStrings #-}
module Types.Option where

import Data.Text as T
import Data.Time.LocalTime

data Option = Option { symbol :: T.Text
                     , expiry :: LocalTime
                     , strike :: Double
                     , price  :: Double
                     } deriving(Read, Show, Eq, Ord)

data OptionEntry = OptionEntry { option :: Option
                               , volume :: Int
                               } deriving(Read, Show, Eq, Ord)


                              
