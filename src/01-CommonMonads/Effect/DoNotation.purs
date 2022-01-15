module CommonMonads.Effect.DoNotation where

import Prelude

import Effect (Effect)

-- Effect monad
doNotation
  :: Effect String
doNotation = do
  one <- pure 1

  two <- pure 2

  pure (show (one + two))
