module MonadTransformers.Layers.StateTExceptT.Right.Transformer where

import Prelude

import Control.Monad.Except (ExceptT(..))
import Control.Monad.State (StateT(..))
import Data.Either (Either(..))
import Data.Identity (Identity(..))
import Data.Tuple (Tuple(..))

-- StateT wrapping ExceptT wrapping monad
-- Right case
transformer                                                                                       {-
  :: Int -> Identity (Either String (Tuple Int Int))                                                 -}
  :: StateT Int (ExceptT String Identity) Int
transformer = do
  three <- StateT (\one -> ExceptT (Identity (Right (Tuple 3 one))))

  -- get the state
  initialState <- StateT (\one -> ExceptT (Identity (Right (Tuple one one))))

  -- put a new state
  StateT (\one -> ExceptT (Identity (Right (Tuple unit (one + three)))))

  -- now the argument is different
  StateT (\four -> ExceptT (Identity (Right (Tuple initialState four))))
