module Types.MetaData where

import Data.Text as T
import Data.Time.LocalTime

data MetaData = MetaData { information :: T.Text    
                         , symbol :: T.Text
                         , lastRefreshed :: LocalTime
                         , interval :: T.Text      
                         , outputSize :: T.Text      
                         , timeZone :: TimeZone      
                         } deriving (Show)           
