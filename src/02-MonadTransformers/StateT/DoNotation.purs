module MonadTransformers.StateT.DoNotation where

import Prelude hiding (bind)

import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Now we modify the hidden state
doNotation                                                                           {-
  :: Int -> Identity (Tuple Int Int)                                             -}
  :: Function Int (Identity (Tuple Int Int))
doNotation = do
  three <- (\one -> Identity (Tuple 3 one))

  -- get the state
  initialState <- (\one -> Identity (Tuple one one))

  -- put a new state
  (\one -> Identity (Tuple unit (one + three)))

  -- now the argument is different
  (\four -> Identity (Tuple initialState four))
















  where
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

  discard = bind
