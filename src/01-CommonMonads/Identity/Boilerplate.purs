module CommonMonads.Identity.Boilerplate where

import Prelude

import Data.Identity (Identity(..))

-- Identity monad
boilerplate
  :: Identity Int
boilerplate =
  case Identity 1 of
    Identity one -> case Identity 2 of
      Identity two -> Identity (one + two)
