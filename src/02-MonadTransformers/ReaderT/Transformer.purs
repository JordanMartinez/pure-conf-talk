module MonadTransformers.ReaderT.Transformer where

import Prelude

import Control.Monad.Reader (ReaderT(..))
import Data.Identity (Identity(..))

-- ReaderT monad
transformer
  :: ReaderT Int Identity String
transformer = do
  two <- ReaderT (\one -> Identity (one + 1))

  four <- ReaderT (\one -> Identity (one * 4))

  ReaderT (\_one -> Identity (show (two + four)))
