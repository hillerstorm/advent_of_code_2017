module Main
  ( main
  ) where

import           Data.ByteString.Char8 (pack, unpack)
import           Data.CaseInsensitive  (mk)
import qualified Data.Map              as M
import           Data.Maybe
import           Network.HTTP.Client
import           System.Environment

import qualified One
import qualified Two
import qualified Three
import qualified Four
import qualified Five
import qualified Six
import qualified Seven
import qualified Eight
import qualified Nine
import qualified Ten
import qualified Eleven
import qualified Twelve
import qualified Thirteen
import qualified Fourteen
import qualified Fifteen
import qualified Sixteen
import qualified Seventeen
import qualified Eighteen
import qualified Nineteen

solved =
  M.fromList
    [ (1, One.solve)
    , (2, Two.solve)
    , (3, Three.solve)
    , (4, Four.solve)
    , (5, Five.solve)
    , (6, Six.solve)
    , (7, Seven.solve)
    , (8, Eight.solve)
    , (9, Nine.solve)
    , (10, Ten.solve)
    , (11, Eleven.solve)
    , (12, Twelve.solve)
    , (13, Thirteen.solve)
    , (14, Fourteen.solve)
    , (15, Fifteen.solve)
    , (16, Sixteen.solve)
    , (17, Seventeen.solve)
    , (18, Eighteen.solve)
    , (19, Nineteen.solve)
    ]

getSolution x = M.findWithDefault notImplemented x solved

solve f s = do
  (a1, a2) <- f . lines <$> s
  putStrLn a1
  putStrLn a2

notImplemented s = ("Not implemented", "Input: " ++ unlines s)

readInput :: String -> Int -> IO String
readInput session ms = do
  initRequest <-
    parseRequest $ "http://adventofcode.com/2017/day/" ++ show ms ++ "/input"
  let session' = "session=" ++ session
      req = initRequest {requestHeaders = [(mk $ pack "Cookie", pack session')]}
  manager <- newManager defaultManagerSettings
  s <- withResponse req manager (brConsume . responseBody)
  return $ concatMap unpack s

maybeRead = fmap fst . listToMaybe . reads

main = do
  arg <- fmap listToMaybe getArgs
  sessionKey <- readFile "sessionKey.txt"
  let ms = arg >>= maybeRead :: Maybe Int
      s = readInput sessionKey
  case ms of
    Just x -> solve (getSolution x) $ s x
    _      -> putStrLn "Usage : aoc <millisecond>"
