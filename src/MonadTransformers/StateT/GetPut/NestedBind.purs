module MonadTransformers.StateT.GetPut.NestedBind where

import Prelude hiding (bind, (>>=))

import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Now we modify the hidden state
nestedBind                                                                        {-
  :: Int -> Identity Tuple String Int                                             -}
  :: Function Int (Identity (Tuple Int Int))
nestedBind = do
  (\one -> Identity (Tuple 3 one)) >>= \three ->

    -- get the state
    (\one -> Identity (Tuple one one)) >>= \initialState ->

      -- put a new state
      (\_one -> Identity (Tuple unit (one + three))) >>= \_unit ->

        -- now the argument is different
        (\four -> Identity (Tuple initialState four))















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