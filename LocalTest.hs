{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy as B
import AccessJSON 
import Control.Exception

urlJSON = "http://www.phoric.eu/temperature.json"
fileInputJSON = "input.json" -- for testing purposes

main :: IO ()
main = do
	t <- try $ AccessJSON.saveLocal $ AccessJSON.readFile fileInputJSON :: IO (Either SomeException ())
	case t of 
		Left x -> print $ "Failed with exception: " ++ show x
		Right _ -> print "Success."
	
-- http://hackage.haskell.org/package/aeson-0.6.1.0/docs/Data-Aeson.html
-- https://www.fpcomplete.com/school/starting-with-haskell/libraries-and-frameworks/text-manipulation/json



