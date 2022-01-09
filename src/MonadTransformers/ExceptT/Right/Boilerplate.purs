module MonadTransformers.ExceptT.Right.Boilerplate where

import Prelude

import Data.Either (Either(..))
import Data.Identity (Identity(..))

-- Either monad's
-- Right case
boilerplate
  :: Identity (Either String Int)
boilerplate =
  case Identity (Right 1) of
    Identity either -> case either of
      Left e1 -> Identity (Left e1)
      Right one -> case Identity (Right 2) of
        Identity either' -> case either' of
          Left e2 -> Identity (Left e2)
          Right two -> Identity (Right (one + two))
