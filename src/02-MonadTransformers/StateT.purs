module MonadTransformers.StateT.GetPut where

import Prelude

import Control.Monad.State (runStateT)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.StateT.Boilerplate (boilerplate)
import MonadTransformers.StateT.DoNotation (doNotation)
import MonadTransformers.StateT.NestedBind (nestedBind)
import MonadTransformers.StateT.Transformer (transformer)
import MonadTransformers.StateT.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "StateT - Boilerplate: "
    <> show (boilerplate 1)
  log
    $ "StateT - Nested Bind: "
    <> show (nestedBind 1)
  log
    $ "StateT - Do Notation: "
    <> show (doNotation 1)
  log
    $ "StateT - Transformer: "
    -- Note: `runStateT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runStateT transformer) 1)
  log
    $ "StateT - Typeclass:   "
    -- Note: `runStateT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runStateT typeclass) 1)