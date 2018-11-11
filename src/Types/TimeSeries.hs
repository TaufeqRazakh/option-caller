module Types.TimeSeries where

import Data.Aeson
    
data TimeSeries = TimeSeries { open :: Double
                  , high :: Double
                  , low :: Double
                  , close :: Double
                  , volume :: Int
                  } deriving (Show)

-- instance ToJSON TimeSeriesinstance FromJSON TimeSerieswhere
--      parseJSON = withObject "TimeSeries" $ \tick -> TimeSeries
--         <$> tick .: "1. open"
--         <*> tick .: "2. high"
--         <*> tick .: "3. low"
--         <*> tick .: "4. close"
--         <*> tick .: "5. volume"