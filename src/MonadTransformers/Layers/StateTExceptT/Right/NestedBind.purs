module MonadTransformers.Layers.StateTExceptT.Right.NestedBind where

import Prelude hiding (bind, (>>=))

import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT wrapping ExceptT wrapping monad
-- Right case
nestedBind                                                                        {-
  :: Int -> Identity (Either String (Tuple String Int))                                             -}
  :: Function Int (Identity (Either String (Tuple Int Int)))
nestedBind = do
  (\one -> Identity (Right (Tuple 3 one))) >>= \three ->

    -- get the state
    (\one -> Identity (Right (Tuple one one))) >>= \initialState ->

      -- put a new state
      (\_one -> Identity (Right (Tuple unit (one + three)))) >>= \_unit ->

        -- now the argument is different
        (\four -> Identity (Right (Tuple initialState four)))















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

infixl 1 bind as >>=