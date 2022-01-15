module CommonMonads.Either.Left2.DoNotation where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Left case
doNotation
  :: Either String Int
doNotation = do
  one <- Right 1

  two <- Left "Error in step 2"

  Right (one + two)
