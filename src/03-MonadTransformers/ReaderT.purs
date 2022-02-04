module MonadTransformers.ReaderT where

import Prelude

import Control.Monad.Reader (runReaderT)
import Effect (Effect)
import Effect.Console (log)
import MonadTransformers.ReaderT.Boilerplate (boilerplate)
import MonadTransformers.ReaderT.DoNotation (doNotation)
import MonadTransformers.ReaderT.NestedBind (nestedBind)
import MonadTransformers.ReaderT.Transformer (transformer)
import MonadTransformers.ReaderT.Typeclass (typeclass)

main :: Effect Unit
main = do
  log
    $ "ReaderT - Boilerplate: "
    <> show (boilerplate 1)
  log
    $ "ReaderT - Nested Bind: "
    <> show (nestedBind 1)
  log
    $ "ReaderT - Do Notation: "
    <> show (doNotation 1)
  log
    $ "ReaderT - Transformer: "
    -- Note: `runReaderT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runReaderT transformer) 1)
  log
    $ "ReaderT - Typeclass:   "
    -- Note: `runReaderT` could be replaced with `unwrap`
    -- from `Data.Newtype (unwrap)`
    <> show ((runReaderT typeclass) 1)