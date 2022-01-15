---
marp: true
---

# Using Monad Transformers without understanding them

---

## About Me

GitHub: [@JordanMartinez](https://github.com/JordanMartinez)

Core Team Member (as of Summer 2020)

Author of ["PureScript: Jordan's Reference"](https://github.com/jordanmartinez/purescript-jordans-reference)

---

## Slides & Code

https://github.com/JordanMartinez/pure-conf-talk

---

## Outcomes

- Why and when people use monad transformers?
- How do I use monad transformers?

---

## Agenda

- What problem do monad transformers solve?
  - The Monad Solution
  - The Monad Transformer Solution

---

## Agenda

- What problem do monad transformers solve?
  - The Monad Solution
  - The Monad Transformer Solution
- Monad transformer examples: "unsugared" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`

---

## Agenda

- What problem do monad transformers solve?
  - The Monad Solution
  - The Monad Transformer Solution
- Monad transformer examples: "unsugared" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Why the monad transformer stack's "order" matters

---

## Agenda

- What problem do monad transformers solve?
  - The Monad Solution
  - The Monad Transformer Solution
- Monad transformer examples: "unsugared" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Why the monad transformer stack's "order" matters
- Hiding stack order via type classes

---

## Presumptions (1/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | ... |
| 2+ arg function application | ... | ... |
| function composition | ... | ... |

---

## Presumptions (2/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | ... |
| 2+ arg function application | `func arg1 arg2` | ... |
| function composition | ... | ... |

---

## Presumptions (3/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | ... |
| 2+ arg function application | `func arg1 arg2` | ... |
| function composition | `aToB >>> bToC` | ... |

---

## Presumptions (4/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg` |
| 2+ arg function application | `func arg1 arg2` | ... |
| function composition | `aToB >>> bToC` | ... |

---

## Presumptions (5/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2` |
| function composition | `aToB >>> bToC` | ... |

---

## Presumptions (6/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2` |
| function composition | `aToB >>> bToC` | `aToBoxB >=> bToBoxC` |

---

## Presumptions (7/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg`<br />`Functor` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2` |
| function composition | `aToB >>> bToC` | `aToBoxB >=> bToBoxC` |

---

## Presumptions (8/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg`<br />`Functor` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2`<br />`Applicative` |
| function composition | `aToB >>> bToC` | `aToBoxB >=> bToBoxC` |

---

## Presumptions (9/9)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg`<br />`Functor` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2`<br />`Applicative` |
| function composition | `aToB >>> bToC` | `aToBoxB >=> bToBoxC`<br />`Monad` |

---

## What problem do monads solve?

```
xxxxxxxxxxx-xxxx "yyyyyyyyyy-yyy" computations
```

---

## What problem do monads solve?

```
xxxxxxxxxxx-xxxx "sequential-ish" computations
```

---

## What problem do monads solve?

```
xxxxxxxxxxx-xxxx "sequential-ish" computations
```

1. Do this

---

## What problem do monads solve?

```
xxxxxxxxxxx-xxxx "sequential-ish" computations
```

1. Do this
2. Then do that

---

## What problem do monads solve?

```
xxxxxxxxxxx-xxxx "sequential-ish" computations
```

1. Do this
2. Then do that
3. Then do something else

---

## What problem do monads solve?

```
xxxxxxxxxxx-xxxx "sequential-ish" computations
```

1. Do this
2. Then do that
3. Then do something else
4. ...

---

## What problem do monads solve?

```
xxxxxxxxxxx-xxxx "sequential-ish" computations
```

---

## What problem do monads solve?

```
boilerplate-free "sequential-ish" computations
```

---

## What problem do monads solve?

```
boilerplate-free "sequential-ish" computations
```

Common Monadic Types:
- `Identity`
- `Either`
- `Effect`
- `Function`

---

## Common Monadic Types: `Identity`

A computation with compile-time newtype boxing and unboxing

---

## Common Monadic Types: `Identity`

- A "placeholder" type for a monad
- "Boxy" function composition

---

## Common Monadic Types: `Either error`

A short-circuiting computation where I care about errors

---

## Common Monadic Types: `Either error`

A short-circuiting computation where I care about errors

"Keep 'computing' until I am done or hit a `Left` case"

---

## Common Monadic Types: `Effect`

A sequence of nested closures

---

## Common Monadic Types: `Effect`

A sequence of nested closures

Provide one closure that runs all others when called

---

## Common Monadic Types: `Function inputArg`

Compute something while having access to the function's argument at any point

---

## What problem do monads solve?

```
boilerplate-free "sequential-ish" computations
```

---

## What problem do monads solve?

```
boilerplate-free "sequential-ish" computations
```

Boilerplate hidden by the `<-` in "do notation"

---

## What problem do monads solve?

```
(boilerplate)-free "sequential-ish" computations
```

Boilerplate hidden by the `<-` in "do notation"

---

## What problem do monads transformers solve?

```
(xxxx xxxx boilerplate)-free "sequential-ish" computations
```

---

## What problem do monads transformers solve?

```
(even more boilerplate)-free "sequential-ish" computations
```

---

## What problem do monads transformers solve?

```
(even more boilerplate)-free "sequential-ish" computations
```

Making `<-` hide even more boilerplate

---

## Question: Why do people use monad transformers?

---

## Question: Why do people use monad transformers?

Answer
- Hide a lot of boilerplate with `<-`

---

## Question: Why do people use monad transformers?

Answer
- Hide a lot of boilerplate with `<-`
- Write more modular code

---

## Question: Why do people use monad transformers?

Answer
- Hide a lot of boilerplate with `<-`
- Write more modular code
- Define interfaces and implement them (Final Tagless)

---

## Remaining work

- Show concrete example of stack of 1
  - shown
  - highlight boilerplate hidden by `<-`
  - don't use any of the 'newtypes', but just set `bind` to something else
- Show concrete example of stack of 2
- Show how stack order does not matter
- Show how stack order does matter
- Making stack order implicit

---