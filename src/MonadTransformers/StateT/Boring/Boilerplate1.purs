module MonadTransformers.StateT.Boring.Boilerplate1 where

import Prelude

import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Same as ReaderT/Function code
boilerplate                                                                         {-
  :: Int -> Identity (Tuple String Int)                                             -}
  :: Function Int (Identity (Tuple String Int))
boilerplate one =
  case Identity (Tuple (one + 1) one) of
    Identity (Tuple two nextState) ->
      case Identity (Tuple (one * 4) nextState) of
        Identity (Tuple four nextState') ->
          Identity (Tuple (show (two + four)) nextState')
