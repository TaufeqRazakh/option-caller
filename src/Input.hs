module Input where

import System.IO
import Data.Text.IO as T
import Data.Text as T

takeSymbol :: IO [Text]
takeSymbol = do
  print $ "type in a symbol you own, the volume, validity date YYYY-MM-DD \n (Use comma and space as separator)"
  sym <- T.getLine
  let sp = T.splitOn (T.pack ", ") sym
  return sp 
  
  
