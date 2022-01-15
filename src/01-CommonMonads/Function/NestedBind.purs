module CommonMonads.Function.NestedBind where

import Prelude

-- Function monad
nestedBind
  :: Function Int String
nestedBind = do
  (\one -> one + 1) >>= \two ->

    (\one -> one * 4) >>= \four ->

      \_one -> show (two + four)
