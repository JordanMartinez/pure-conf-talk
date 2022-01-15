module MonadTransformers.StateT.Boring.Boilerplate2 where

import Prelude

import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Same as ReaderT/Function code
boilerplate                                                                         {-
  :: Int -> Identity (Tuple String Int)                                             -}
  :: Function Int (Identity (Tuple String Int))
boilerplate one = do
  let initialState = Tuple (one + 1) one
  Tuple two state1 <- Identity initialState
  let nextInput = Tuple (one * 4) state1
  Tuple four state2 <- Identity nextInput
  let finalOutputAndState = Tuple (show (two + four)) state2
  Identity finalOutputAndState
