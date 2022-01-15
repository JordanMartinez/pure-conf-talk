module MonadTransformers.StateT.GetPut.Transformer2 where

import Prelude

import Control.Monad.State (class MonadState, get, put)

-- StateT monad itself is hidden
-- Now we modify the hidden state
transformer                                                                           {-
  :: Int -> monadicType (Tuple Int Int)                                                 -}
  :: forall monadicType
   . MonadState Int monadicType
  => monadicType Int
transformer = do
  three <- pure 3

  -- get the state
  initialState <- get

  -- put a new state
  put (one + three)

  -- now the argument is different
  pure initialState

