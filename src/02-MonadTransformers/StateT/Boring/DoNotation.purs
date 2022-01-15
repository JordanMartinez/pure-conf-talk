module MonadTransformers.StateT.Boring.DoNotation where

import Prelude hiding (bind)

import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT monad
-- Same as ReaderT/Function code
doNotation                                                                           {-
  :: Int -> Identity (Tuple String Int)                                             -}
  :: Function Int (Identity (Tuple String Int))
doNotation = do
  two <- (\one -> Identity (Tuple (one + 1) one))

  four <- (\one -> Identity (Tuple (one * 4) one))

  (\_one -> Identity (Tuple (show (two + four)) one))
















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
