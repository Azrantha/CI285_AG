{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad	(msum)
import Control.Monad.IO.Class (liftIO)
import Happstack.Server (nullConf, simpleHTTP, ok, dir, uriRest, seeOther)
import qualified Data.ByteString.Lazy as B
import AccessJSON 
import Control.Exception
import Foreign.Marshal.Unsafe

{--
	A Happstack Server that will either append the json found at the url 
	supplied after the input directory into the local storage or display
	all current data in the storage and some other usage messages at any
	other directory (via redirecting to output directory).
--}
main :: IO ()
main = simpleHTTP nullConf $ msum
	[ dir "input" $ uriRest $ \s -> ok $ unsafeLocalState $ input s
	, dir "output" $ ok $ output
	, seeOther ("/output"  :: String) "/output"
	]

{--
	Output string for the output directory in main
--}
output :: String
output = "Current data: \n" ++ tempsToStr AccessJSON.readLocal ++ "\
 \ \nTo enter new data please navigate to /input/[your input URL] \n\
 \ For an example, try \
 \ http://localhost:8000/input/http://itsuite.it.brighton.ac.uk/ag343/input.json\
 \ You may also try input2, and input3, which will override some of the values \
 \ of the other json files to demonstrate this program"
	

{--
	Pattern matches as (x:url) to remove leading '/' from input/ directory.
	Then this function will try to read json from the url at the given string
	and supply appropriate status messages depending on what is/isn't found
	at the url.
--}
input :: String -> IO String
input (x:url) = do
	r <- try (evaluate $ AccessJSON.readURL url)::IO (Either SomeException [Temperature])
	case r of
		Left x -> return $ "Failed with error message: \n" ++ show x
		Right y -> do
			if (y == []) 
				then return "Failed: Input empty or invalid JSON format."
				else do
					AccessJSON.saveLocal y
					return "Success."
	
{--
From back when I used path instead of uriRest, and hence had to ask users
to input urls all '/' replaced with with '\'
formatURL :: String -> String
formatURL (x:xs) = if (x=='\\') then '/':formatURL xs else x : (formatURL xs)
formatURL (x)	= x
--}


-- hosted on localhost:8000
-- sources used when creating project: 
-- http://hackage.haskell.org/ -- various package directories
-- https://www.fpcomplete.com/school/starting-with-haskell/libraries-and-frameworks/text-manipulation/json
-- http://happstack.com/docs/crashcourse/index.html#serving-files-from-a-directory
-- http://stackoverflow.com/questions/6009384/exception-handling-in-haskell





