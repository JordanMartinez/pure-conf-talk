module Layers.ExceptTStateT.Right.Transformer where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Control.Monad.State (StateT(..))
import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- ExceptT wrapping StateT wrapping monad
-- Right case
transformer {-
:: Int -> Identity (Tuple (Either String Int) Int)                                                 -} 
  :: ExceptT String (StateT Int Identity) Int
transformer = do
  three <- ExceptT $ StateT (\one -> Identity (Tuple (Right 3) one))

  -- get the state
  initialState <- ExceptT $ StateT (\one -> Identity (Tuple (Right one) one))

  -- put a new state
  ExceptT $ StateT (\_one -> Identity (Tuple (Right unit) (initialState + three)))

  -- now the argument is different
  ExceptT $ StateT (\four -> Identity (Tuple (Right initialState) four))
