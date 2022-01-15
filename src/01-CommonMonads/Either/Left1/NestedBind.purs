module CommonMonads.Either.Left1.NestedBind where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Left case
nestedBind
  :: Either String Int
nestedBind = do
  (Left "Error in step 1") >>= \one ->

    Right 2 >>= \two ->

      Right (one + two)
