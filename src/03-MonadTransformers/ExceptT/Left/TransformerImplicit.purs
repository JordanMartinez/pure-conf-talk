module MonadTransformers.ExceptT.Left.TransformerImplicit where

import Prelude

import Control.Monad.Except (ExceptT, throwError)
import Data.Identity (Identity)


-- ExceptT monad's
-- Left case
transformerImplicit
  :: ExceptT String Identity Int
transformerImplicit = do
  one <- throwError "Error in step 1"

  two <- pure 2

  pure (one + two)
