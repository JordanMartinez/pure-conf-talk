module Layers.StateTExceptT.Right where

import Prelude

import Control.Monad.Except (runExceptT)
import Control.Monad.State (runStateT)
import Effect (Effect)
import Effect.Console (log)
import Layers.StateTExceptT.Right.Boilerplate (boilerplate)
import Layers.StateTExceptT.Right.DoNotation (doNotation)
import Layers.StateTExceptT.Right.NestedBind (nestedBind)
import Layers.StateTExceptT.Right.Transformer (transformer)

main :: Effect Unit
main = do
  log
    $ "StateTExcepT - Right - Boilerplate: "
    <> show (boilerplate 1)
  log
    $ "StateTExcepT - Right - Nested Bind: "
    <> show (nestedBind 1)
  log
    $ "StateTExcepT - Right - Do Notation: "
    <> show (doNotation 1)
  log
    $ "StateTExcepT - Right - Transformer: "
    -- Note: `runStateT` and `runExceptT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show (runExceptT (runStateT transformer 1))