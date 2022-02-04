# Cheatsheet

## Sugaring a Concrete Type into a Monad Transformer Stack

1. Identify the "base" monad
1. Look at the output type and desugar accordingly:
    - if a `Maybe`, then sugar into `MaybeT`
    - if an `Either`, then sugar into `ExceptT`
    - if a `List`, then sugar into `ListT`
    - if a `Tuple a x` where `x` is a standalone `Monoid`, then sugar into `WriterT`
    - if a `Tuple a x` where `x` is part of a function argument's type, then sugar into `StateT`
    - if just an `a` and the monad is the output of a single-arg function, then sugar into a `ReaderT`
    - if just an `a` and the monad is the output of a callback-like function, then sugar into a `ContT`
1. Repeat step 2 until fully sugared

## Desugaring a Monad Transformer Stack into a Concrete Type

1. Identify the "base" monad
1. Find the innermost transformer
1. Desugar the transformer
1. Repeat step 2 until fully desugared

## Monad Transformer Stack Order

### Why It Matters

Most of the time, the order of the stack itself doesn't matter unless one is using either `MaybeT` or `ExceptT` somewhere because it short-circuits. Due to the need to throw and catch errors, one of these two transformers is usually the first layer that wraps the "base" monad.

| Transformer Stack | Verbose Type | Explanation | Impliciations
| - | - | - | - |
| `MaybeT (StateT s Identity output)` | `state -> Identity (Tuple state (Maybe output))` | A computation that returns back some state and the result of a short-circuiting computation where you don't care about the error | If a `Nothing` case occurs, you still have the final `state` value |
| `StateT s (MaybeT Identity output)` | `state -> Identity (Maybe (Tuple state output))` | A short-circuting computation that, when fully successful, returns back the computation's result and some state | If a `Nothing` case occurs, you lose what the final `state` value was |
| `ExceptT error (StateT s Identity output)` | `state -> Identity (Tuple state (Either error output))` | A computation that returns back some state and the result of a short-circuiting computation | If a `Left` case occurs, you still have the final `state` value |
| `StateT s (ExceptT error Identity output)` | `state -> Identity (Either error (Tuple state output))` | A short-circuting computation that, when fully successful, returns back the computation's result and some state | If a `Left` case occurs, you lose what the final `state` value was |

### Ordering the Stack

Type Signatures: outermost to innermost
```purescript
program
  :: forall monad output
   . Monad monad
  => StateT Int (ExceptT String monad) output
```
Unwrapping: innermost is on the outside because it's the *last* newtype to unwrap. Outermost is on the inside because it's the *first* newtype to unwrap.
```purescript
runExceptT (runStateT program initialState)
```