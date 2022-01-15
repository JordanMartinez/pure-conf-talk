module MonadTransformers.Layers.StateTExceptT.Right.Boilerplate where

import Prelude hiding (bind, (>>=))

import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT wrapping ExceptT wrapping monad
-- Right case
boilerplate                                                                               {-
  :: Int -> Identity (Either String (Tuple String Int))                                             -}
  :: Function Int (Identity (Either String (Tuple Int Int)))
boilerplate one =
  case Identity         (Right (Tuple 3            one)) of
    Identity            (Left err) ->
      Identity (Left err)
    Identity            (Right (Tuple three        state1)) ->
      -- get the state
      case Identity     (Right (Tuple state1       state1)) of
        Identity        (Left err) ->
          Identity (Left err)
        Identity        (Right (Tuple initialState state2)) ->
          -- put the state
          case Identity (Right (Tuple unit         (state2 + three))) of
            Identity    (Left err) ->
              Identity (Left err)
            Identity    (Right (Tuple _unit        four)) ->
              -- now the argument is different
              Identity  (Right (Tuple initialState four))















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