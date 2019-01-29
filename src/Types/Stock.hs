module Types.Stock where

import Data.Text as T

data Stock = Stock { symbol :: T.Text
                   , value  :: Double
                   , price  :: Double
                   }  deriving(Show, Eq, Ord)
