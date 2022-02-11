module Layers.ExceptTStateT.Left where

import Prelude

import Control.Monad.Except (runExceptT)
import Control.Monad.State (runState, runStateT)
import Effect (Effect)
import Effect.Console (log)
import Layers.ExceptTStateT.Left.Boilerplate (boilerplate)
import Layers.ExceptTStateT.Left.DoNotation (doNotation)
import Layers.ExceptTStateT.Left.NestedBind (nestedBind)
import Layers.ExceptTStateT.Left.Transformer (transformer)
import Layers.ExceptTStateT.Left.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "ExceptTStateT - Left - Boilerplate: "
    <> show (boilerplate 1)
  log
    $ "ExceptTStateT - Left - Nested Bind: "
    <> show (nestedBind 1)
  log
    $ "ExceptTStateT - Left - Do Notation: "
    <> show (doNotation 1)
  log
    $ "ExceptTStateT - Left - Transformer: "
    -- Note: `runStateT` and `runExceptT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show (runStateT (runExceptT transformer) 1)
  log
    $ "ExceptTStateT - Left - Typeclass:   "
    -- Note: usage of `runState` here forces monad to be `Identity`
    <> show (runState (runExceptT typeclass) 1)
