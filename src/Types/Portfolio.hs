module Types.Portfolio where

import Types.Option
import Types.Stock
import Data.Text as T 

-- data Portfolio = Portfolio { options :: [Option]
--                            , stocks  :: [Stock]
--                            } deriving(Show, Eq)

data Portfolio = Portfolio { options :: Maybe Option 
                           , stocks :: Maybe [Stock]
                           } deriving(Show, Eq, Ord)