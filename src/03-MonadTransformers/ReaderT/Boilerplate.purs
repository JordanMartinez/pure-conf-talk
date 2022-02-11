module MonadTransformers.ReaderT.Boilerplate where

import Prelude

import Data.Identity (Identity(..))

-- ReaderT monad
boilerplate
  :: Function Int (Identity String)
boilerplate one =
  case Identity         2 of
    Identity two ->
      case Identity     4 of
        Identity four ->
          case Identity one of
            Identity _one ->
              Identity (show (two + four + one))
