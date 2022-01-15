module MonadTransformers.StateT.Boring.NestedBind where

import Prelude hiding (bind, (>>=))

import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Same as ReaderT/Function code
nestedBind                                                                        {-
  :: Int -> Identity Tuple String Int                                             -}
  :: Function Int (Identity (Tuple String Int))
nestedBind = do
  (\one -> Identity (Tuple (one + 1) one)) >>= \two ->

    (\one -> Identity (Tuple (one * 4) one)) >>= \four ->

      \_one -> Identity (Tuple (show (two + four)) one)
















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