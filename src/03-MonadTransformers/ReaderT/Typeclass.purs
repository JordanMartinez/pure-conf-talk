module MonadTransformers.ReaderT.Typeclass where

import Prelude

import Control.Monad.Reader (ReaderT(..), ask)
import Data.Identity (Identity(..))

-- ReaderT monad
typeclass
  :: ReaderT Int Identity String
typeclass = do
  two <- ReaderT (\one -> Identity (one + 1))

  four <- ReaderT (\one -> Identity (one * 4))

  one <- ask

  pure (show (two + four + one))
