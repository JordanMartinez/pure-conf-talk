module CommonMonads.Either.Left1.DoNotation where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Left case
doNotation
  :: Either String Int
doNotation = do
  one <- Left "Error in step 1"

  two <- Right 2

  Right (one + two)
