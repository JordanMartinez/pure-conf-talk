# Cheatsheet
## Sugaring a Concrete Type into a Monad Transformer Stack

1. Identify the "base" monad (referenced as `m` below)
1. Look at the output type and sugar accordingly:
    a. if a `Maybe a`, then `m` becomes `MaybeT m`
    b. if an `Either e a`, then sugar into `ExceptT e m`
    c. if a `Tuple a x`
        - if `x` is a standalone `Monoid`, then sugar into `WriterT x m a`
        - if `x` is passed in via a function argument, then sugar into `StateT x m a`
    e. if just an `a` and the monad is the output of a single-arg function (`r -> m a`), then sugar into a `ReaderT r m a`
2. Repeat step 2 until fully sugared

### Example

```purescript
-- 1. Identify the base monad
r -> s -> m (Tuple (Either e a) s)
--        ^

-- 2. Look at the output type and identify transformer
r -> s -> m (Tuple (Either e a) s)
-- > Check 1: Output is Tuple
--        m (Tuple (a         ) s)
-- > Check 2: is `s` standalone (i.e. WriterT) or passed in via function (i.e. StateT)?
--   s ->                       s
-- > Answer: Passed in via function. Use `StateT`

-- 3. Sugar accordingly
r -> s -> m (Tuple (Either e a) s)                {-
r -> s -> m (Tuple (a         ) s)                -}
r -> StateT s m (Either e a)

-- 4. Identify the base monad
r -> StateT s m (Either e a)
--   ^^^^^^^^^^

-- 5. Look at the output type and identify transformer
r -> StateT s m (Either e a)
--               ^^^^^^^^^^
-- > Output is Either
--               Either e a
-- > Answer: ExceptT

-- 6. Sugar accordingly
r -> StateT s m (Either e a)                {-
r -> m          (Either e a)                -}
r -> ExceptT e (StateT s m) a

-- 7. Look at the output type and identify transformer
r -> ExceptT e (StateT s m) a                               {-
                            ^
> Output is unchanged. Is there a function argument?
r -> m                      a
> Answer: ReaderT                                           -}

-- 7. Sugar accordingly
r -> ExceptT e (StateT s m) a                               {-
r -> m                      a                               -}
ReaderT r (ExceptT e (StateT s m)) a
```

## Desugaring a Monad Transformer Stack into a Concrete Type

1. Find the outermost transformer
2. Desugar the transformer:
    a. if a `MaybeT m a`, then sugar into `m (Maybe a)` and update `m` to refer to `m (Maybe)`
    b. if an `ExceptT e m a`, then sugar into `m (Either e a)` and update `m` to refer to `m (Either e)`
    c. if a `WriterT w m a`, ten sugar into `m (Tuple a w)` and update `m` to refer to `m (Tuple _ w)`
    d. if a `StateT s m a`, then sugar into `s -> m (Tuple a s)` and update `m` to refer to `m (Tuple _ s)`
    e. if a `ReaderT r m a`, then sugar into `r -> m a`
3. Go to step 1 until fully desugared

### Example

```purescript
-- 1. Find outermost transformer
ReaderT r (ExceptT e (StateT s m)) a                    {-
ReaderT r m                        a                    -}

-- 2. Desugar the transformer
ReaderT r    (ExceptT e (StateT s m)) a                    {-
ReaderT r    m                        a                    -}
(       r -> ExceptT e (StateT s m)   a)

-- 3. Find the outermost transformer
r -> ExceptT e (StateT s m) a                               {-
     ExceptT e m            a                               -}

-- 4. Desugar the outermost transformer
r -> ExceptT e (StateT s m)          a                     {-
     ExceptT e (m         )          a                     -}
r ->            StateT s m (Either e a)

-- 5. Find the outermost transformer
r ->            StateT s m (Either e a)                    {-
                StateT s m a                               -}

-- 6. Desugar the outermost transformer
r ->            StateT s m (Either e a)                    {-
                StateT s m a                               -}
r ->            s -> m (Tuple (Either e a) s)

-- 7. Remove whitespaces
r -> s -> m (Tuple (Either e a) s)
```

## Monad Transformer Stack

Here's a simple monadic computation:
`monad output`

When we transform it with a transformer, it looks like we wrap the monad in layers
`ExceptT error (monad) output`
`StateT s (ExceptT error (monad)) output`
`ReaderT reader (State state (ExceptT error (monad))) output`

To remove the newtypes, we have to call their corresponding function `runXT` where `X` refers to `Reader`, `Except`, or `State`. We can visualize this as a stack where each call to the corresponding function "pops off" a layer from the stack. Starting with this...

```
-- Top of stack
ReaderT
StateT
ExceptT
monad
-- Bottom of stack
```

we unwrap each transformer one at a time.

```
-- start
ReaderT
StateT
ExceptT
monad

-- result after `runReaderT`
StateT
ExceptT
monad

-- result after `runStateT`
ExceptT
monad

-- result after `runExceptT`
monad
```

### Why the Order of a Monad Transformer Stack Matters

Most of the time, the order of the stack itself doesn't matter unless one is using either `MaybeT` or `ExceptT` somewhere because it short-circuits. Due to the need to throw and catch errors, one of these two transformers is usually the first layer that wraps the "base" monad.

| Transformer Stack                          | Verbose Type                                            | Explanation                                                                                                                      | Impliciations                                                         |
| ------------------------------------------ | ------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| `MaybeT (StateT s Identity output)`        | `state -> Identity (Tuple state (Maybe output))`        | A computation that returns back some state and the result of a short-circuiting computation where you don't care about the error | If a `Nothing` case occurs, you still have the final `state` value    |
| `StateT s (MaybeT Identity output)`        | `state -> Identity (Maybe (Tuple state output))`        | A short-circuting computation that, when fully successful, returns back the computation's result and some state                  | If a `Nothing` case occurs, you lose what the final `state` value was |
| `ExceptT error (StateT s Identity output)` | `state -> Identity (Tuple state (Either error output))` | A computation that returns back some state and the result of a short-circuiting computation                                      | If a `Left` case occurs, you still have the final `state` value       |
| `StateT s (ExceptT error Identity output)` | `state -> Identity (Either error (Tuple state output))` | A short-circuting computation that, when fully successful, returns back the computation's result and some state                  | If a `Left` case occurs, you lose what the final `state` value was    |

### Running the Stack

Because the outermost transformer in the type signature must be unwrapped **first**, it is the **first** `run...T` function called, not the last.

| Position in stack | Type Signature Position | `run...T` position |
| ----------------- | ----------------------- | ------------------ |
| Top               | Outermost               | Called first       |
| Bottom            | Innermost               | Called last        |

```purescript
-- The "stack" is:
--    StateT
--    ExceptT
--    monad
program
  :: forall monad output
   . Monad monad
  => StateT Int (ExceptT String monad) output                         {-
  => Int -> ExceptT String monad (Tuple output Int)
  => Int ->                monad (Tuple (Either String output) Int)   -}
program = do
 ...

runProgram :: monad (Tuple (Either String output) Int)
runProgram =
  bottomLayerUnwrapped -- i.e. runExceptT (runStateT program initialState)
  where
  topLayerUnwrapped :: ExceptT String monad (Tuple output Int)
  topLayerUnwrapped = runStateT program initialIntState

  bottomLayerUnwrapped :: monad (Tuple (Either String output) Int)
  bottomLayerUnwrapped = runExceptT topLayerUnwrapped
```