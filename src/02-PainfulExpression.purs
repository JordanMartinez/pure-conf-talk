module PainfulExpression where

import Prelude

import Data.Either (Either(..))
import Data.Tuple (Tuple(..))
import Effect (Effect)
import Effect.Console (log)

type ReadOnlyConfig =
  { age :: Int
  , max :: Int
  }

type State = Int
type Output = String
type Error = String

main :: Effect Unit
main = do
  let config = { age: 8, max: 10 }
  let x = 5
  out <- example config x
  log $ show out

effect :: forall a. a -> Effect a
effect = pure

-- foo <- Identity a
-- foo <- Effect a
-- foo <- effect a

example :: ReadOnlyConfig -> State -> Effect (Tuple (Either Error Output) State)
example config initialState =
  catchBlock tryBlock
  where
  tryBlock :: Effect (Tuple (Either Error Output) State)
  tryBlock = do
    -- read `x`
    Tuple either1 x <- effect (Tuple (Right unit) initialState)
    case either1 of
      Left e1 -> do
        effect (Tuple (Left e1) x)
      Right _ -> do
        -- `x1 = x + globalRef1`
        Tuple either2 x1 <- effect (Tuple (Right unit) (x + config.age))
        case either2 of
          Left e2 -> do
            effect (Tuple (Left e2) x1)
          Right _ -> do
            log $ "x is " <> show x1
            if x1 > config.max then do
              effect (Tuple (Left "x is too large") x1)
            else do
              effect (Tuple (Right "Everything is fine") x1)

  catchBlock
    :: Effect (Tuple (Either Error Output) State)
    -> Effect (Tuple (Either Error Output) State)
  catchBlock tryPart = do
    original@(Tuple eitherPart state) <- tryPart
    case eitherPart of
      Right _ -> do
        effect original
      Left errMsg -> do
        log errMsg
        effect (Tuple (Right "What did you do!?") state)
