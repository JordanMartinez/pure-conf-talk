module MonadTransformers.Layers.StateTExceptT.Left where

import Prelude

import Control.Monad.Except (runExceptT)
import Control.Monad.State (runStateT)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.Layers.StateTExceptT.Left.Boilerplate (boilerplate)
import MonadTransformers.Layers.StateTExceptT.Left.DoNotation (doNotation)
import MonadTransformers.Layers.StateTExceptT.Left.NestedBind (nestedBind)
import MonadTransformers.Layers.StateTExceptT.Left.Transformer (transformer)

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