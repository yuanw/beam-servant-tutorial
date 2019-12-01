{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module API where

import qualified Data.Map                 as M
import           Data.Proxy
import           Network.Wai.Handler.Warp (run)
import           Servant
import           User

-- "users" say
type UserAPI1 = "users" :> Get '[JSON] [User]

type UserAPI2 =
  "users" :> Get '[JSON] [User]
    :<|> "albert" :> Get '[JSON] User
    :<|> "issac" :> Get '[JSON] User

type ProtectedAPI2 = BasicAuth "my-real" User :> UserAPI2


server1 :: Server UserAPI1
server1 = return users1

server2 :: Server UserAPI2
server2 = return users1 :<|> return albert :<|> return issac

userAPI :: Proxy UserAPI2
userAPI = Proxy

app1 :: Application
app1 = serve userAPI server2

main :: IO ()
main = run 8081 app1
