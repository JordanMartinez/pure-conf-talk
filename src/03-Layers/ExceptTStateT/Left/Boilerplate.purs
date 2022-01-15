module Layers.ExceptTStateT.Left.Boilerplate where

import Prelude hiding (bind, (>>=))

import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- ExceptT wrapping StateT wrapping monad
-- Left case
boilerplate                                                                               {-
  :: Int -> Identity (Tuple (Either String Int) Int)                                                 -}
  :: Function Int (Identity (Tuple (Either String Int) Int))
boilerplate one =
  case Identity         (Tuple (Right 3)            one) of
    Identity            (Tuple (Left err)           state1) ->
      Identity (Tuple (Left err) state1)
    Identity            (Tuple (Right three)        state1) ->
      -- get the state
      case Identity     (Tuple (Right state1)       state1) of
        Identity        (Tuple (Left err)           state2) ->
          Identity (Tuple (Left err) state2)
        Identity        (Tuple (Right initialState) state2) ->
          -- put the state
          case Identity (Tuple (Left "Could not put state!") (state2 + three)) of
            Identity    (Tuple (Left err)        four) ->
              Identity (Tuple (Left err) four)
            Identity    (Tuple (Right _unit)        four) ->
              -- now the argument is different
              Identity  (Tuple (Right initialState) four)
