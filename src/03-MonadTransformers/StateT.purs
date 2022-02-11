module MonadTransformers.StateT where

import Prelude

import Control.Monad.State (runStateT)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.StateT.Boilerplate (boilerplate)
import MonadTransformers.StateT.DoNotation (doNotation)
import MonadTransformers.StateT.NestedBind (nestedBind)
import MonadTransformers.StateT.TransformerExplicit (transformerExplicit)
import MonadTransformers.StateT.TransformerImplicit (transformerImplicit)
import MonadTransformers.StateT.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "StateT - Boilerplate:     "
    <> show (boilerplate 1)
  log
    $ "StateT - Nested Bind:     "
    <> show (nestedBind 1)
  log
    $ "StateT - Do Notation:     "
    <> show (doNotation 1)
  log
    $ "StateT - Transformer (E): "
    -- Note: `runStateT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runStateT transformerExplicit) 1)
  log
    $ "StateT - Transformer (I): "
    -- Note: `runStateT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runStateT transformerImplicit) 1)
  log
    $ "StateT - Typeclass:       "
    -- Note: `runStateT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runStateT typeclass) 1)