module MonadTransformers.StateT.Boring.Transformer where

import Prelude

import Control.Monad.State (StateT(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Same as ReaderT/Function code
transformer                                                                           {-
  :: StateT (Int -> Identity Tuple String Int)                                             -}
  :: StateT Int Identity String
transformer = do
  two <- StateT (\one -> Identity (Tuple (one + 1) one))

  four <- StateT (\one -> Identity (Tuple (one * 4) one))

  StateT (\one -> Identity (Tuple (show (two + four)) one))
