-- http://hackage.haskell.org/package/aeson-1.4.1.0/docs/Data-Aeson.html
-- { "name": "Joe", "age": 12 }

-- {-# LANGUAGE DeriveGeneric #-}

-- import GHC.Generics

-- data Person = Person {
--       name :: Text
--     , age  :: Int
--     } deriving (Generic, Show)

{-# LANGUAGE DeriveGeneric #-}

module Types.Tick where 

import GHC.Generics

-- 2018-11-05 13:35:00 
-- 1. open "106.9510"
-- 2. high "107.0100"
-- 3. low  "106.7000"
-- 4. close    "106.7248"
-- 5. volume   "260934"

-- using field labels
data Tick = Tick {
    open :: Double
  , high :: Double
  , low :: Double
  , close :: Double
  , volume :: Int
    }