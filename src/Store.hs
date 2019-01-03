module Store where
import System.IO
import System.Directory (getTemporaryDirectory, removeFile)

-- create a load destination for each symbol
withLoadDestination :: String -> IO Handle
withLoadDestination pattern = do 
    putStrLn "Opening file in local project"
    -- Here is an alternative temporary directory to use 
    -- when building the project 
    -- tempDir <- catch (getTemporaryDirectory) (\_ -> ".")
    let tempDir = "." -- Use this for testing in this project
    (tempFile, temph) <- openTempFile tempDir (pattern ++ ".json")
    return temph
    -- need to implement a way to close all tempFiles 
    -- after the application terminates
    -- finally (pulldata)
    --         (do hclose temph
    --             removeFile tempFile)

inStoreHs :: IO ()
inStoreHs =  putStrLn "Yes!! you made it to to Store.hs inside src"