module Main where

import Prelude

import Control.Monad.Except (runExceptT, throwError)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))

import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Exception (message)

-- purescript-aff
import Effect.Aff (Aff, launchAff_)

-- purescript-node-process
import Node.Process as Process

-- purescript-js-date
import Data.JSDate (now, toISOString)

-- purescript-github-actions-toolkit
import GitHub.Actions.Core as Core
import GitHub.Actions.IO as IO

main :: Effect Unit
main = launchAff_ (runWhich >>= work >>> liftEffect)

work :: String -> Effect Unit
work stack = do
  Core.info ("curl: " <> stack)

  et_name <- runExceptT $
    Core.getInput {name: "who-to-greet", options: Just {required: true}}

  case et_name of
    Right name -> greetAndSetOutput name
    Left err -> Core.setFailed (message err)

runWhich :: Aff String
runWhich = do
  et_path <- runExceptT (IO.which {tool: "curl", check: Just true})
  case et_path of
    Right path -> pure path
    Left err -> throwError err

greetAndSetOutput :: String -> Effect Unit
greetAndSetOutput name = do
  Core.info $ "Hello, " <> name <> "!"

  time <- now >>= toISOString
  Core.setOutput {name: "time", value: time}

  let key = "GITHUB_ACTOR"
  mb_runner <- Process.lookupEnv key
  Core.info $ case mb_runner of
    Just runner -> key <> ": " <> runner
    _ -> "NO " <> key <> "found in process env"

  Core.info $ case Process.platform of
    Just pf -> "Platform: " <> show pf
    _ -> "Unknown platform"
