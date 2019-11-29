{-# LANGUAGE DeriveGeneric #-}

module Alpaca where

import           Data.Aeson
import           GHC.Generics

data Color = White | Beige | Brown | Black | Silver
         deriving (Generic, Show)

data Alpaca = Alpaca {
     name  :: String
   , color :: Color
   , age   :: Int
} deriving (Generic, Show)

instance ToJSON Color
instance FromJSON Color
instance ToJSON Alpaca
instance FromJSON Alpaca
