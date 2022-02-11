module MonadTransformers.ReaderT.Typeclass where

import Prelude

import Control.Monad.Reader (class MonadReader, ask)

-- ReaderT monad
typeclass
  :: forall m
   . MonadReader Int m
  => m String
typeclass = do
  two <- pure 2

  four <- pure 4

  one <- ask

  pure (show (two + four + one))
