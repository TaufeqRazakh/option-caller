{-# LANGUAGE OverloadedStrings #-}

module Types.Tick.JSON where 

import Data.Aeson
import Types.Tick

instance FromJSON Tick where
    parseJSON = withObject "Tick" $ \v -> Tick
        <$> v .: "name"
        <*> v .: "age"

