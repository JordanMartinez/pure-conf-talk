module CommonMonads.Either.Left2.NestedBind where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Left case
nestedBind
  :: Either String Int
nestedBind = do
  Right 1 >>= \one ->

    Left "Error in step 2" >>= \two ->

      Right (one + two)
