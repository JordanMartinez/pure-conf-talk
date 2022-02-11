module Layers.ExceptTStateT.Right.Typeclass where

import Prelude

import Control.Monad.Except (class MonadError)
import Control.Monad.State (class MonadState, get, put)

-- ExceptT wrapping StateT wrapping monad
-- Right case
typeclass {-
  :: Int -> Identity (Tuple (Either String Int) Int)                                                 -}
  :: forall m
   . MonadState Int m
  => MonadError String m
  => m Int
typeclass = do
  three <- pure 3

  -- get the state
  initialState <- get

  -- put a new state
  put (initialState + three)

  -- now the argument is different
  pure initialState
