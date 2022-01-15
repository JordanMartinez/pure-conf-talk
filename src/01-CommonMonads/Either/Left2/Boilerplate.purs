module CommonMonads.Either.Left2.Boilerplate where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Left case
boilerplate
  :: Either String Int
boilerplate =
  case Right 1 of
    Left e1 -> Left e1
    Right one -> case Left "Error in step 2" of
      Left e2 -> Left e2
      Right two -> Right (one + two)
