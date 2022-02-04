module MonadTransformers.ExceptT.Right.Typeclass where

import Prelude

import Control.Monad.Except (ExceptT)
import Data.Identity (Identity)

-- ExceptT monad's
-- Right case
typeclass
  :: ExceptT String Identity Int
typeclass = do
  one <- pure 1

  two <- pure 2

  pure (one + two)
