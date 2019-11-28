{-#LANGUAGE DeriveGeneric#-}
module User where

import Data.Aeson.Types
import Data.Time.Calendar

import GHC.Generics

data SortBy = Age | Name

data User = User
  { name :: String
  , age  ::  Int
  , email :: String
  , registration_date :: Day
  } deriving (Eq, Show, Generic)

instance ToJSON User

users1 :: [User]
users1 =
  [ User "Isaac Newton"    372 "isaac@newton.co.uk" (fromGregorian 1683  3 1)
  , User "Albert Einstein" 136 "ae@mc2.org"         (fromGregorian 1905 12 1)
  ]
