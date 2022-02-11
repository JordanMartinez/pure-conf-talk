module Layers.StateTExceptT.Left where

import Prelude

import Control.Monad.Except (runExceptT)
import Control.Monad.State (runStateT)
import Data.Identity (Identity)
import Effect (Effect)
import Effect.Console (log)
import Layers.StateTExceptT.Left.Boilerplate (boilerplate)
import Layers.StateTExceptT.Left.DoNotation (doNotation)
import Layers.StateTExceptT.Left.NestedBind (nestedBind)
import Layers.StateTExceptT.Left.Transformer (transformer)
import Layers.StateTExceptT.Left.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "StateTExcepT - Left - Boilerplate: "
    <> show (boilerplate 1)
  log
    $ "StateTExcepT - Left - Nested Bind: "
    <> show (nestedBind 1)
  log
    $ "StateTExcepT - Left - Do Notation: "
    <> show (doNotation 1)
  log
    $ "StateTExcepT - Left - Transformer: "
    -- Note: `runStateT` and `runExceptT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show (runExceptT (runStateT transformer 1))
  log
    $ "StateTExcepT - Left - Typeclass:   "
    -- Note: `runStateT` and `runExceptT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runExceptT (runStateT typeclass 1)) :: Identity _)
