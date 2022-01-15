module CommonMonads.Function.Boilerplate where

import Prelude

-- Function monad
boilerplate
  :: Function Int String
boilerplate one =
  case one + 1 of
    two -> case one * 4 of
      four -> show (two + four)
