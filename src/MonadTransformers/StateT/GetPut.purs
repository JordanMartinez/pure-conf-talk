module MonadTransformers.StateT.GetPut where

import Prelude

import Control.Monad.State (runStateT)
import Data.Identity (Identity)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.StateT.GetPut.Boilerplate (boilerplate)
import MonadTransformers.StateT.GetPut.DoNotation (doNotation)
import MonadTransformers.StateT.GetPut.NestedBind (nestedBind)
import MonadTransformers.StateT.GetPut.Transformer1 as Trans1
import MonadTransformers.StateT.GetPut.Transformer2 as Trans2

main :: Effect Unit
main = do
  log
    $ "StateT - GetPut - Boilerplate:  "
    <> show (boilerplate 1)
  log
    $ "StateT - GetPut - Nested Bind:  "
    <> show (nestedBind 1)
  log
    $ "StateT - GetPut - Do Notation:  "
    <> show (doNotation 1)
  log
    $ "StateT - GetPut - Transformer1: "
    -- Note: `runStateT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runStateT Trans1.transformer) 1)
  log
    $ "StateT - GetPut - Transformer2: "
    -- The `Identity` annotation is needed here because
    -- the underlying monadic type cannot be inferred without it.
    <> show (((runStateT Trans2.transformer) 1) :: Identity _)