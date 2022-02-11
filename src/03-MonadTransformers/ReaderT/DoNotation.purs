module MonadTransformers.ReaderT.DoNotation where

import Prelude hiding (bind)

import Data.Identity (Identity(..))

-- ReaderT monad
doNotation
  :: Function Int (Identity String)
doNotation = do
  two <- (\_one -> Identity 2)

  four <- (\_one -> Identity 4)

  one <- (\one -> Identity one)

  (\_one -> Identity (show (two + four + one)))

















  where
  bind
    :: forall input a b
      . (Function input (Identity a))
    -> (a -> (Function input (Identity b)))
    -> (Function input (Identity b))
  bind inputToIdentityA f = \input ->
    case inputToIdentityA input of
      Identity a ->
        let
          inputToIdentityB = f a
        in
          inputToIdentityB input
