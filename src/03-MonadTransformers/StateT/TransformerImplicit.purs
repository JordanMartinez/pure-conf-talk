module MonadTransformers.StateT.TransformerImplicit where

import Prelude

import Control.Monad.State (StateT, get, put)
import Data.Identity (Identity)

-- StateT monad
-- Now we modify the hidden state
transformerImplicit                                                                           {-
  :: Int -> Identity (Tuple Int Int)                                                 -}
  :: StateT Int Identity Int
transformerImplicit = do
  three <- pure 3

  -- get the state
  initialState <- get

  -- put a new state
  put (one + three)

  -- now the argument is different
  pure initialState

