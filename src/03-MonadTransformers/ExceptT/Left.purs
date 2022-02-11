module MonadTransformers.ExceptT.Left where

import Prelude

import Control.Monad.Except (runExceptT)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.ExceptT.Left.Boilerplate (boilerplate)
import MonadTransformers.ExceptT.Left.DoNotation (doNotation)
import MonadTransformers.ExceptT.Left.NestedBind (nestedBind)
import MonadTransformers.ExceptT.Left.TransformerExplicit (transformerExplicit)
import MonadTransformers.ExceptT.Left.TransformerImplicit (transformerImplicit)
import MonadTransformers.ExceptT.Left.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "ExceptT - Left Boilerplate:     "
    <> show boilerplate
  log
    $ "ExceptT - Left Nested Bind:     "
    <> show nestedBind
  log
    $ "ExceptT - Left Do Notation:     "
    <> show doNotation
  log
    $ "ExceptT - Left Transformer (E): "
    <> show (runExceptT transformerExplicit)
  log
    $ "ExceptT - Left Transformer (I): "
    <> show (runExceptT transformerImplicit)
  log
    $ "ExceptT - Left Typeclass:       "
    <> show (runExceptT typeclass)
