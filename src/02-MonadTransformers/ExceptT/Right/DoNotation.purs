module MonadTransformers.ExceptT.Right.DoNotation where

import Prelude hiding ((>>=), bind)

import Data.Either (Either(..))
import Data.Identity (Identity(..))

-- ExceptT monad's
-- Right case
doNotation
  :: Identity (Either String Int)
doNotation = do
  one <- Identity (Right 1)

  two <- Identity (Right 2)

  Identity (Right (one + two))














  where
  bind
    :: forall a b
     . Identity (Either String a)
    -> (a -> Identity (Either String b))
    -> Identity (Either String b)
  bind ma f = case ma of
    Identity either -> case either of
      Left e -> Identity (Left e)
      Right a -> f a
