module CommonMonads.Identity.NestedBind where

import Prelude

import Data.Identity (Identity(..))

-- Identity monad's
nestedBind
  :: Identity Int
nestedBind = do
  Identity 1 >>= \one ->

    Identity 2 >>= \two ->

      Identity (one + two)
