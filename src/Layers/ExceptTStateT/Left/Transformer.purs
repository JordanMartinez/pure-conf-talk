module Layers.ExceptTStateT.Left.Transformer where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Control.Monad.State (StateT(..))
import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- ExceptT wrapping StateT wrapping monad
-- Left case
transformer                                                                                       {-
  :: Int -> Identity (Tuple (Either String Int) Int)                                                 -}
  :: ExceptT String (StateT Int Identity) Int
transformer = do
  three <- ExceptT $ StateT (\one -> Identity (Tuple (Right 3) one))

  -- get the state
  initialState <- ExceptT $ StateT (\one -> Identity (Tuple (Right one) one))

  -- put a new state
  _ <- ExceptT $ StateT (\one -> Identity (Tuple (Left "Could not put state!") (one + three)))

  -- now the argument is different
  ExceptT $ StateT (\four -> Identity (Tuple (Right initialState) four))
