module MonadTransformers.ExceptT.Right where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Data.Identity (Identity)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.ExceptT.Right.Boilerplate (boilerplate)
import MonadTransformers.ExceptT.Right.DoNotation (doNotation)
import MonadTransformers.ExceptT.Right.NestedBind (nestedBind)
import MonadTransformers.ExceptT.Right.Transformer (transformer)
import MonadTransformers.ExceptT.Right.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "ExceptT - Right Boilerplate: "
    <> show boilerplate
  log
    $ "ExceptT - Right Nested Bind: "
    <> show nestedBind
  log
    $ "ExceptT - Right Do Notation: "
    <> show doNotation
  log
    $ "ExceptT - Right Transformer: "
    <> showT transformer
  log
    $ "ExceptT - Right Typeclass:   "
    <> showT typeclass


-- Necessary because ExceptT doesn't have a `Show` instance
showT :: forall a. Show a => ExceptT String Identity a -> String
showT (ExceptT id) = "ExceptT(" <> show id <> ")"
