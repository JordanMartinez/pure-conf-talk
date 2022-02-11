module MonadTransformers.ReaderT.TransformerImplicit where

import Prelude

import Control.Monad.Reader (ReaderT, ask)
import Data.Identity (Identity)

-- ReaderT monad
transformerImplicit
  :: ReaderT Int Identity String
transformerImplicit = do
  two <- pure 2

  four <- pure 4

  one <- ask

  pure (show (two + four + one))
