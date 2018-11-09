module SymbolObtain where 

takeSymbols :: String -> String -> String
takeSymbols s k = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" ++ s ++ "&interval=5min&apikey=" ++ k