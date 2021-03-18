module Main where

import Prelude

import Control.Monad.Except (runExceptT)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (message)

-- purescript-js-date
import Data.JSDate (now, toISOString)

-- purescript-github-actions-toolkig
import GitHub.Actions.Core as Core

main :: Effect Unit
main = do
  result <- runExceptT $ do
    name <- Core.getInput { name: "who-to-greet"
                          , options: Just { required: true } }
    liftEffect $ Core.info $ "Hello, " <> name <> "!"

  case result of
    Right _ -> do
      time <- now >>= toISOString
      Core.setOutput { name: "time"
                     , value: time }
    Left err -> Core.setFailed (message err)
