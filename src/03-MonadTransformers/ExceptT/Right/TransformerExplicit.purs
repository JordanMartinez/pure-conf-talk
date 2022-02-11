module MonadTransformers.ExceptT.Right.TransformerExplicit where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Data.Either (Either(..))
import Data.Identity (Identity(..))

-- ExceptT monad's
-- Right case
transformerExplicit
  :: ExceptT String Identity Int
transformerExplicit = do
  one <- ExceptT (Identity (Right 1))

  two <- ExceptT (Identity (Right 2))

  ExceptT (Identity (Right (one + two)))
