module MonadTransformers.ExceptT.Left.Transformer where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Data.Either (Either(..))
import Data.Identity (Identity(..))

-- ExceptT monad's
-- Left case
transformer
  :: ExceptT String Identity Int
transformer = do
  one <- ExceptT (Identity (Left "Error in step 1"))

  two <- ExceptT (Identity (Right 2))

  ExceptT (Identity (Right (one + two)))
