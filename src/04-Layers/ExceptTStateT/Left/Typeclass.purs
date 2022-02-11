module Layers.ExceptTStateT.Left.Typeclass where

import Prelude

import Control.Monad.Except (class MonadError, throwError)
import Control.Monad.State (class MonadState, get)

-- ExceptT wrapping StateT wrapping monad
-- Left case
typeclass                                                                                       {-
  :: Int -> Identity (Tuple (Either String Int) Int)                                                 -}
  :: forall m
   . MonadState Int m
  => MonadError String m
  => m Int
typeclass = do
  _three <- pure 3

  -- get the state
  initialState <- get

  -- put a new state
  _ <- throwError "Could not put state!"

  -- now the argument is different
  pure initialState
