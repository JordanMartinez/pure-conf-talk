module MonadTransformers.ExceptT.Left.Typeclass where

import Prelude

import Control.Monad.Except (ExceptT, throwError)
import Data.Identity (Identity)

-- ExceptT monad's
-- Left case
typeclass
  :: ExceptT String Identity Int
typeclass = do
  one <- throwError "Error in step 1"

  two <- pure 2

  pure (one + two)
