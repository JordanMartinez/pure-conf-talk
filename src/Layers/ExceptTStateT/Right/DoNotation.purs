module Layers.ExceptTStateT.Right.DoNotation where

import Prelude hiding (bind)

import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- ExceptT wrapping StateT wrapping monad
-- Right case
doNotation                                                                               {-
  :: Int -> Identity (Tuple (Either String Int) Int)                                                 -}
  :: Function Int (Identity (Tuple (Either String Int) Int))
doNotation = do
  three <- (\one -> Identity (Tuple (Right 3) one))

  -- get the state
  initialState <- (\one -> Identity (Tuple (Right one) one))

  -- put a new state
  (\one -> Identity (Tuple (Right unit) (one + three)))

  -- now the argument is different
  (\four -> Identity (Tuple (Right initialState) four))
















  where
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

  discard = bind
