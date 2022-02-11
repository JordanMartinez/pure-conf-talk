module MonadTransformers.ExceptT.Left where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Data.Identity (Identity)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.ExceptT.Left.Boilerplate (boilerplate)
import MonadTransformers.ExceptT.Left.DoNotation (doNotation)
import MonadTransformers.ExceptT.Left.NestedBind (nestedBind)
import MonadTransformers.ExceptT.Left.TransformerImplicit (transformerImplicit)
import MonadTransformers.ExceptT.Left.TransformerExplicit (transformerExplicit)
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
    <> showT transformerExplicit
  log
    $ "ExceptT - Left Transformer (I): "
    <> showT transformerImplicit
  log
    $ "ExceptT - Left Typeclass:       "
    <> showT typeclass

-- Necessary because ExceptT doesn't have a `Show` instance
showT :: forall a. Show a => ExceptT String Identity a -> String
showT (ExceptT id) = "ExceptT(" <> show id <> ")"
