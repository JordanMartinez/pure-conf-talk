module MonadTransformers.ReaderT.Boilerplate where

import Prelude

import Data.Identity (Identity(..))

-- ReaderT monad
boilerplate
  :: Function Int (Identity String)
boilerplate one =
  case Identity (one + 1) of
    Identity two -> case Identity (one * 4) of
      Identity four -> Identity (show (two + four))
