module MonadTransformers.ExceptT.Left.Boilerplate where

import Prelude

import Data.Either (Either(..))
import Data.Identity (Identity(..))

-- Either monad's
-- Left case
boilerplate
  :: Identity (Either String Int)
boilerplate =
  case Identity (Left "Error in step 1") of
    Identity either -> case either of
      Left e1 -> Identity (Left e1)
      Right one -> case Identity (Right 2) of
        Identity either' -> case either' of
          Left e2 -> Identity (Left e2)
          Right two -> Identity (Right (one + two))
