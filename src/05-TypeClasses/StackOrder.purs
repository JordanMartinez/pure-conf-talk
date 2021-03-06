module TypeClasses.StackOrder where

import Prelude

import Control.Monad.Except (class MonadError, runExcept, runExceptT, throwError)
import Control.Monad.State (class MonadState, get, put, runState, runStateT)
import Data.Identity (Identity)
import Effect (Effect)
import Effect.Console (log)

-- 1 interface
-- 2 implementations
-- Monad Transformer "Stack" order matters!
program
  :: forall monadicType
   . MonadState Int monadicType
  => MonadError String monadicType
  => monadicType Boolean
program = do
  initialState <- get
  unless (initialState < 3) do
    throwError $ "Initial state must be less than 3!"
  put 0
  pure true

-- Note: the first transformer newtype we unwrap is the OUTERMOST transformer.
main :: Effect Unit
main = do
  log "No Errors (happy path)"
  log
    $ "ExceptTStateT: "
        -- The type annotation here is only needed because the
        -- monadic type is not specified. Is it `Identity`? `Either`? `Array`?
        -- The compiler has no way to know.
        <> show (runExceptT (runStateT program 1) :: Identity _)
  log
    $ "StateTExceptT: "
        <> show (runStateT (runExceptT program) 1 :: Identity _)

  log "\nErrors"
  log
    $ "ExceptTStateT: "
        -- `runExcept` is `runExceptT` with the `monadicType` specified to `Identity`
        -- So, no type annotation is needed here.
        <> show (runExcept (runStateT program 5))
  log
    $ "StateTExceptT: "
        -- Each monad transformer has a `runNameT` and `runName` function
        -- Both unwrap the newtype. The latter indicates the monad is `Identity`.
        <> show (runState (runExceptT program) 5)