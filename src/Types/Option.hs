{-# LANGUAGE OverloadedStrings #-}
module Types.Option where

import Data.Text as T
import Data.Time.LocalTime

data Option = Option { symbol :: T.Text
                     , expiry :: LocalTime
                     , strike :: Double
                     , price  :: Double
                     } deriving(Show, Eq, Ord)