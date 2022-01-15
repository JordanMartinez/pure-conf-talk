module MonadTransformers.StateT.GetPut.Transformer where

import Prelude

import Control.Monad.State (StateT(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Now we modify the hidden state
transformer                                                                           {-
  :: Int -> Identity (Tuple Int Int)                                                 -}
  :: StateT Int Identity Int
transformer = do
  three <- StateT (\one -> Identity (Tuple 3 one))

  -- get the state
  initialState <- StateT (\one -> Identity (Tuple one one))

  -- put a new state
  StateT (\one -> Identity (Tuple unit (one + three)))

  -- now the argument is different
  StateT (\four -> Identity (Tuple initialState four))

