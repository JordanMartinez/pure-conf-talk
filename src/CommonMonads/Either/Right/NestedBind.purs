module CommonMonads.Either.Right.NestedBind where

import Prelude

import Data.Either (Either(..))

-- Either monad's
-- Right case
nestedBind
  :: Either String Int
nestedBind = do
  Right 1 >>= \one ->

    Right 2 >>= \two ->

      Right (one + two)
