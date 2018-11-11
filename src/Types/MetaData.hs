module Types.MetaData where

import Data.Aeson
import Data.Time

data MetaData = MetaData { information :: String
                         , symbol :: String
                         , lastRefreshed :: LocalTime
                         , interval :: String
                         , outputSize :: String
                         } deriving (Show)

-- instance ToJSON MetaData 
-- instance FromJSON MetaData where
--     parseJSON = withObject "MetaData" $ \amd -> MetaData
--         <$> amd .: "1. Information"
--         <*> amd .: "2. Symbol"
--         <*> amd .: "3. Last Refreshed"
--         <*> amd .: "4. Interval"
--         <*> amd .: "5. Output Size"
