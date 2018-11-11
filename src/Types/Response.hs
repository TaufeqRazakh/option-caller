module Types.Response where

import Data.Aeson

-- data TimeSeriesResponse = TimeSeriesResponse { metaData :: AlphaMetaData
--                                              , ticks :: Map UTCTime Tick
--                                              } deriving (Show)

-- instance ToJSON TimeSeriesResponse 
-- instance FromJSON TimeSeriesResponse where
--      parseJSON = withObject "TimeSeriesResponse" $ \tsr -> TimeSeriesResponse
--         <$> tsr .: "Meta Data"
--         <*> tsr .: "Time Series (5min)"