module Layers.StateTExceptT.Right.DoNotation where

import Prelude hiding (bind)

import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT wrapping ExceptT wrapping monad
-- Right case
doNotation                                                                        {-
  :: Int -> Identity (Either String (Tuple String Int))                           -}
  :: Function Int (Identity (Either String (Tuple Int Int)))
doNotation = do
  three <- (\one -> Identity (Right (Tuple 3 one)))

  -- get the state
  initialState <- (\one -> Identity (Right (Tuple one one)))

  -- put a new state
  (\one -> Identity (Right (Tuple unit (one + three))))

  -- now the argument is different
  (\four -> Identity (Right (Tuple initialState four)))
















  where
  bind
    :: forall input a b
     . (Function input (Identity (Either String (Tuple a input))))
    -> (a -> (Function input (Identity (Either String (Tuple b input)))))
    -> (Function input (Identity (Either String (Tuple b input))))
  bind stateToIdentityA f = \initialState ->
    case stateToIdentityA initialState of
      Identity eitherErrOrA -> case eitherErrOrA of
        Left e -> Identity (Left e)
        Right (Tuple a nextState) ->
          let
            inputToIdentityB :: input -> Identity (Either String (Tuple b input))
            inputToIdentityB = f a
          in inputToIdentityB nextState

  discard = bind
