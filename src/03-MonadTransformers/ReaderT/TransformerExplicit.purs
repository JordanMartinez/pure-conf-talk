module MonadTransformers.ReaderT.TransformerExplicit where

import Prelude

import Control.Monad.Reader (ReaderT(..))
import Data.Identity (Identity(..))

-- ReaderT monad
transformerExplicit
  :: ReaderT Int Identity String
transformerExplicit = do
  two <- ReaderT (\_one -> Identity 2)

  four <- ReaderT (\_one -> Identity 4)

  one <- ReaderT (\one -> Identity one)

  ReaderT (\_one -> Identity (show (two + four + one)))
