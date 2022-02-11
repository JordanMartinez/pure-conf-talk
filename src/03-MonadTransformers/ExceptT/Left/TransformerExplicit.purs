module MonadTransformers.ExceptT.Left.TransformerExplicit where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Data.Either (Either(..))
import Data.Identity (Identity(..))

-- ExceptT monad's
-- Left case
transformerExplicit
  :: ExceptT String Identity Int
transformerExplicit = do
  one <- ExceptT (Identity (Left "Error in step 1"))

  two <- ExceptT (Identity (Right 2))

  ExceptT (Identity (Right (one + two)))
