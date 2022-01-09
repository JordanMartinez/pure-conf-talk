module MonadTransformers.ExceptT.Right.NestedBind where

import Prelude hiding ((>>=), bind)

import Data.Either (Either(..))
import Data.Identity (Identity(..))

-- Either monad's
-- Left case
nestedBind
  :: Identity (Either String Int)
nestedBind =
  (Identity (Right 1)) >>= \one ->

    (Identity (Right 2)) >>= \two ->

      Identity (Right (one + two))




bind
  :: forall a b
    . Identity (Either String a)
  -> (a -> Identity (Either String b))
  -> Identity (Either String b)
bind ma f = case ma of
  Identity either -> case either of
    Left e -> Identity (Left e)
    Right a -> f a

infixl 1 bind as >>=