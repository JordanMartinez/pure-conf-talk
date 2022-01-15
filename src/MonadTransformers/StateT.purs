module MonadTransformers.StateT where

import Prelude

import Control.Monad.State (runStateT)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.StateT.Boring.Boilerplate1 as BP1
import MonadTransformers.StateT.Boring.Boilerplate2 as BP2
import MonadTransformers.StateT.Boring.DoNotation (doNotation)
import MonadTransformers.StateT.Boring.NestedBind (nestedBind)
import MonadTransformers.StateT.Boring.Transformer (transformer)

main :: Effect Unit
main = do
  log
    $ "StateT - Boilerplate 1: "
    <> show (BP1.boilerplate 1)
  log
    $ "StateT - Boilerplate 2: "
    <> show (BP2.boilerplate 1)
  log
    $ "StateT - Nested Bind:   "
    <> show (nestedBind 1)
  log
    $ "StateT - Do Notation:   "
    <> show (doNotation 1)
  log
    $ "StateT - Transformer:   "
    -- Note: `runStateT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runStateT transformer) 1)