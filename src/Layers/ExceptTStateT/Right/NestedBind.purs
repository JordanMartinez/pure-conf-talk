module Layers.ExceptTStateT.Right.NestedBind where

import Prelude hiding (bind, (>>=))

import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- ExceptT wrapping StateT wrapping monad
-- Right case
nestedBind                                                                               {-
  :: Int -> Identity (Tuple (Either String Int) Int)                                                 -}
  :: Function Int (Identity (Tuple (Either String Int) Int))
nestedBind = do
  (\one -> Identity (Tuple (Right 3) one)) >>= \three ->

    -- get the state
    (\one -> Identity (Tuple (Right one) one)) >>= \initialState ->

      -- put a new state
      (\_one -> Identity (Tuple (Right unit) (one + three))) >>= \_unit ->

        -- now the argument is different
        (\four -> Identity (Tuple (Right initialState) four))















bind
  :: forall input a b
   . (Function input (Identity (Tuple (Either String a) input)))
  -> (a -> (Function input (Identity (Tuple (Either String b) input))))
  -> (Function input (Identity (Tuple (Either String b) input)))
bind stateToIdentityA f = \initialState ->
  case stateToIdentityA initialState of
    Identity (Tuple eitherErrOrA nextState) -> case eitherErrOrA of
      Left e -> Identity (Tuple (Left e) nextState)
      Right a ->
        let
          inputToIdentityB :: input -> Identity (Tuple (Either String b) input)
          inputToIdentityB = f a
        in inputToIdentityB nextState

infixl 1 bind as >>=