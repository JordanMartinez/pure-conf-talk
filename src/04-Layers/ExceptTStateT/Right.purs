module Layers.ExceptTStateT.Right where

import Prelude

import Control.Monad.Except (runExceptT)
import Control.Monad.State (runStateT)
import Data.Identity (Identity)
import Effect (Effect)
import Effect.Console (log)
import Layers.ExceptTStateT.Right.Boilerplate (boilerplate)
import Layers.ExceptTStateT.Right.DoNotation (doNotation)
import Layers.ExceptTStateT.Right.NestedBind (nestedBind)
import Layers.ExceptTStateT.Right.Transformer (transformer)
import Layers.ExceptTStateT.Right.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "ExceptTStateT - Right - Boilerplate: "
    <> show (boilerplate 1)
  log
    $ "ExceptTStateT - Right - Nested Bind: "
    <> show (nestedBind 1)
  log
    $ "ExceptTStateT - Right - Do Notation: "
    <> show (doNotation 1)
  log
    $ "ExceptTStateT - Right - Transformer: "
    -- Note: `runStateT` and `runExceptT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show (runStateT (runExceptT transformer) 1)
  log
    $ "ExceptTStateT - Right - Typeclass:   "
    -- Note: usage of `runState` here forces monad to be `Identity`
    <> show ((runStateT (runExceptT typeclass) 1) :: Identity _)
