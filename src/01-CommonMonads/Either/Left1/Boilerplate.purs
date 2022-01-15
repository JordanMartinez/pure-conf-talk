module CommonMonads.Either.Left1.Boilerplate where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Left case
boilerplate
  :: Either String Int
boilerplate =
  case Left "Error in step 1" of
    Left e1 -> Left e1
    Right one -> case Right 2 of
      Left e2 -> Left e2
      Right two -> Right (one + two)
