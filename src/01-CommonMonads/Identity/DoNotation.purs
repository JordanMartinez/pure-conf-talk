module CommonMonads.Identity.DoNotation where

import Prelude

import Data.Identity (Identity(..))

-- Identity monad's
doNotation
  :: Identity Int
doNotation = do
  one <- Identity 1

  two <- Identity 2

  Identity (one + two)
