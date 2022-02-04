module MonadTransformers.StateT.Typeclass where

import Prelude

import Control.Monad.State (StateT(..), get, put)
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Now we modify the hidden state
typeclass                                                                           {-
  :: Int -> Identity (Tuple Int Int)                                                 -}
  :: StateT Int Identity Int
typeclass = do
  three <- StateT (\one -> Identity (Tuple 3 one))

  -- get the state
  initialState <- get

  put (initialState + three)

  -- now the argument is different
  pure initialState

