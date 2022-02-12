module MonadTransformers.ExceptT.Right.TransformerImplicit where

import Prelude

import Control.Monad.Except (ExceptT)
import Data.Identity (Identity)


-- ExceptT monad's
-- Right case
transformerImplicit
  :: ExceptT String Identity Int
transformerImplicit = do
  one <- pure 1

  two <- pure 2

  pure (one + two)
