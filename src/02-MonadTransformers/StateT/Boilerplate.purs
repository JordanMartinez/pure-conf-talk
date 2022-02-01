module MonadTransformers.StateT.Boilerplate where

import Prelude hiding (bind, (>>=))

import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Now we modify the hidden state
boilerplate                                                                        {-
  :: Int -> Identity (Tuple String Int)                                             -}
  :: Function Int (Identity (Tuple Int Int))
boilerplate one =
  case Identity         (Tuple 3            one) of
    Identity            (Tuple three        state1) ->
      -- get the state
      case Identity     (Tuple state1       state1) of
        Identity        (Tuple initialState state2) ->
          -- put the state
          case Identity (Tuple unit         (state2 + three)) of
            Identity    (Tuple _unit        four) ->
              -- now the argument is different
              Identity  (Tuple initialState four)















bind
  :: forall input a b
   . (Function input (Identity (Tuple a input)))
  -> (a -> (Function input (Identity (Tuple b input))))
  -> (Function input (Identity (Tuple b input)))
bind stateToIdentityA f = \initialState ->
  case stateToIdentityA initialState of
    Identity (Tuple a nextState) ->
      let
        inputToIdentityB = f a
      in
        inputToIdentityB nextState

infixl 1 bind as >>=