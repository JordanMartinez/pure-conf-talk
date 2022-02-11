module Layers.StateTExceptT.Left.Typeclass where

import Prelude

import Control.Monad.Except (class MonadError, throwError)
import Control.Monad.State (class MonadState, get)

-- StateT wrapping ExceptT wrapping monad
-- Left case
typeclass {-
:: Int -> Identity (Either String (Tuple Int Int))                                                 -}
  :: forall m
   . MonadState Int m
  => MonadError String m
  => m Int
typeclass = do
  _three <- pure 3

  -- get the state
  initialState <- get

  -- put a new state
  _ <- throwError "Could not put the state!"

  -- now the argument is different
  pure initialState
