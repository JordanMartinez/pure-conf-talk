module TypeClasses.DifferentMonads where

import Prelude

import Control.Monad.Except (class MonadError, runExceptT, throwError)
import Control.Monad.State (class MonadState, get, put, runStateT)
import Data.Either (Either)
import Data.Identity (Identity)
import Data.Maybe (Maybe)
import Data.Tuple (Tuple)
import Effect (Effect)
import Effect.Console (log)

-- Wait! Did you say "forall monadicType" 🤔😏

-- 1 interface
-- 2 implementations
-- N monadic types
program
  :: forall monadicType
   . MonadState Int monadicType
  => MonadError String monadicType
  => monadicType Boolean
program = do
  initialState <- get
  unless (initialState < 3) do
    throwError $ "Initial state '" <> show initialState <> "' must be less than 3!"
  put 0
  pure true

main :: Effect Unit
main = do
  log "=== Identity ==="
  log "No Errors"
  log
    $ "ExceptTStateT - Identity - initial state of 1: "
    <> show (runExceptT (runStateT program 1) :: Identity (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Identity - initial state of 1: "
    <> show (runStateT (runExceptT program) 1 :: Identity (Tuple (Either String Boolean) Int))
  log "\nErrors"
  log
    $ "ExceptTStateT - Identity - initial state of 5: "
    <> show (runExceptT (runStateT program 5) :: Identity (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Identity - initial state of 5: "
    <> show (runStateT (runExceptT program) 5 :: Identity (Tuple (Either String Boolean) Int))

  log "\n\n=== Maybe ==="
  log "No Errors"
  log
    $ "ExceptTStateT - Maybe - initial state of 1: "
    <> show (runExceptT (runStateT program 1) :: Maybe (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Maybe - initial state of 1: "
    <> show (runStateT (runExceptT program) 1 :: Maybe (Tuple (Either String Boolean) Int))
  log "\nErrors"
  log
    $ "ExceptTStateT - Maybe - initial state of 5: "
    <> show (runExceptT (runStateT program 5) :: Maybe (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Maybe - initial state of 5: "
    <> show (runStateT (runExceptT program) 5 :: Maybe (Tuple (Either String Boolean) Int))

  log "\n\n=== Either Boolean ==="
  log "No Errors"
  log
    $ "ExceptTStateT - Either Boolean - initial state of 1: "
    <> show (runExceptT (runStateT program 1) :: Either Boolean (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Either Boolean - initial state of 1: "
    <> show (runStateT (runExceptT program) 1 :: Either Boolean (Tuple (Either String Boolean) Int))
  log "\nErrors"
  log
    $ "ExceptTStateT - Either Boolean - initial state of 5: "
    <> show (runExceptT (runStateT program 5) :: Either Boolean (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Either Boolean - initial state of 5: "
    <> show (runStateT (runExceptT program) 5 :: Either Boolean (Tuple (Either String Boolean) Int))

  log "\n\n=== Array ==="
  log "No Errors"
  log
    $ "ExceptTStateT - Array - initial state of 1: "
    <> show (runExceptT (runStateT program 1) :: Array (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Array - initial state of 1: "
    <> show (runStateT (runExceptT program) 1 :: Array (Tuple (Either String Boolean) Int))
  log "\nErrors"
  log
    $ "ExceptTStateT - Array - initial state of 5: "
    <> show (runExceptT (runStateT program 5) :: Array (Either String (Tuple Boolean Int)))
  log
    $ "StateTExceptT - Array - initial state of 5: "
    <> show (runStateT (runExceptT program) 5 :: Array (Tuple (Either String Boolean) Int))

  -- Note: the single use of `log` in the below examples enables the compiler to infer
  -- that the monadic type is `Effect`. Otherwise, an annotation would be needed.
  --
  -- The below examples are equivalent to
  -- ```
  -- result <- runStateT (runExceptT program) initialState
  -- log $ "Implementation - Effect - initial state of X: " <> show result
  -- ```
  log "\n\n=== Effect ==="
  log "No Errors"
  join $ map (log <<< append "ExceptTStateT - Effect - initial state of 1: " <<< show) do
    runExceptT (runStateT program 1)
  join $ map (log <<< append "StateTExceptT - Effect - initial state of 1: " <<< show) do
    runStateT (runExceptT program) 1
  log "\nErrors"
  join $ map (log <<< append "ExceptTStateT - Effect - initial state of 5: " <<< show) do
    runExceptT (runStateT program 5)
  join $ map (log <<< append "StateTExceptT - Effect - initial state of 5: " <<< show) do
    runStateT (runExceptT program) 5
