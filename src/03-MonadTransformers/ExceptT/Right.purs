module MonadTransformers.ExceptT.Right where

import Prelude

import Control.Monad.Except (runExceptT)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.ExceptT.Right.Boilerplate (boilerplate)
import MonadTransformers.ExceptT.Right.DoNotation (doNotation)
import MonadTransformers.ExceptT.Right.NestedBind (nestedBind)
import MonadTransformers.ExceptT.Right.TransformerExplicit (transformerExplicit)
import MonadTransformers.ExceptT.Right.TransformerImplicit (transformerImplicit)
import MonadTransformers.ExceptT.Right.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "ExceptT - Right Boilerplate:     "
    <> show boilerplate
  log
    $ "ExceptT - Right Nested Bind:     "
    <> show nestedBind
  log
    $ "ExceptT - Right Do Notation:     "
    <> show doNotation
  log
    $ "ExceptT - Right Transformer (E): "
    <> show (runExceptT transformerExplicit)
  log
    $ "ExceptT - Right Transformer (I): "
    <> show (runExceptT transformerImplicit)
  log
    $ "ExceptT - Right Typeclass:       "
    <> show (runExceptT typeclass)
