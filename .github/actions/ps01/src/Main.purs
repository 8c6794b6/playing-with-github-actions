module Main where

import Prelude

import Control.Monad.Except (runExceptT)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

import Effect (Effect)
import Effect.Exception (message)

-- purescript-node-process
import Node.Process as Process

-- purescript-js-date
import Data.JSDate (now, toISOString)

-- purescript-github-actions-toolkig
import GitHub.Actions.Core as Core

main :: Effect Unit
main = do
  result <- runExceptT $
     Core.getInput { name: "who-to-greet"
                   , options: Just { required: true } }

  case result of
    Right name -> greetAndSetOutput  name
    Left err -> Core.setFailed (message err)

greetAndSetOutput :: String -> Effect Unit
greetAndSetOutput name = do
  Core.info $ "Hello, " <> name <> "!"

  time <- now >>= toISOString
  Core.setOutput { name: "time", value: time }

  let key = "GITHUB_ACTOR"
  mb_runner <- Process.lookupEnv key
  Core.info $ case mb_runner of
    Just runner -> key <> ": " <> runner
    _ -> "NO GITHUB_RUNNER found in process"
