module MonadTransformers.ReaderT.NestedBind where

import Prelude hiding (bind, (>>=))

import Data.Identity (Identity(..))

-- ReaderT monad
nestedBind
  :: Function Int (Identity String)
nestedBind = do
  (\_one -> Identity 2) >>= \two ->

    (\_one -> Identity 4) >>= \four ->

      (\one -> Identity one) >>= \one ->

        \_one -> Identity (show (two + four + one))


















bind
  :: forall input a b
    . (Function input (Identity a))
  -> (a -> (Function input (Identity b)))
  -> (Function input (Identity b))
bind inputToIdentityA f = \input -> case inputToIdentityA input of
  Identity a ->
    let
      inputToIdentityB = f a
    in
      inputToIdentityB input

infixl 1 bind as >>=