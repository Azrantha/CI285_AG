module Paths_Assignment (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/home/moogle/.cabal/bin"
libdir     = "/home/moogle/.cabal/lib/Assignment-0.1.0.0/ghc-7.6.3"
datadir    = "/home/moogle/.cabal/share/Assignment-0.1.0.0"
libexecdir = "/home/moogle/.cabal/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "Assignment_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Assignment_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Assignment_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Assignment_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
