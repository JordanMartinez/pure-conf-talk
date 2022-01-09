module CommonMonads.Either.Right.DoNotation where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Right case
doNotation
  :: Either String Int
doNotation = do
  one <- Right 1

  two <- Right 2

  Right (one + two)
