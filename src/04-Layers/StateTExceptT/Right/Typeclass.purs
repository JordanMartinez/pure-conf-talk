module Layers.StateTExceptT.Right.Typeclass where

import Prelude

import Control.Monad.Except (class MonadError)
import Control.Monad.State (class MonadState, get, put)

-- StateT wrapping ExceptT wrapping monad
-- Right case
typeclass {-
:: Int -> Identity (Either String (Tuple Int Int))                                                 -}
  :: forall m
   . MonadState Int m
  => MonadError String m
  => m Int
typeclass = do
  three <- pure 3

  -- get the state
  initialState <- get

  put (initialState + three)

  -- now the argument is different
  pure initialState
