module CommonMonads.Function.DoNotation where

import Prelude

-- Function monad
doNotation
  :: Function Int String
doNotation = do
  two <- (\one -> one + 1)

  four <- (\one -> one * 4)

  \_one -> show (two + four)
