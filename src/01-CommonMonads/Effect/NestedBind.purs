module CommonMonads.Effect.NestedBind where

import Prelude

import Effect (Effect)

-- Effect monad
nestedBind
  :: Effect String
nestedBind = do
  (pure 1) >>= \one ->

    (pure 2) >>= \two ->

      pure (show (one + two))
