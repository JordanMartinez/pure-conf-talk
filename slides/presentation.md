---
marp: true
---

# Using Monad Transformers without understanding them

---

## About Me

GitHub: [@JordanMartinez](https://github.com/JordanMartinez)

Core Team Member (as of Summer 2020)

Author of ["PureScript: Jordan's Reference"](https://github.com/jordanmartinez/purescript-jordans-reference)

Work at Arista Networks, Inc.

---

## Code, Slides, & Recording

https://github.com/JordanMartinez/pure-conf-talk

---

## Outcomes

- Why use monad transformers?
- When?
- How?

---

## Agenda

- What problem do monads & monad transformers solve?

---

## Agenda

- What problem do monads & monad transformers solve?
- "boilerplate" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`

---

## Agenda

- What problem do monads & monad transformers solve?
- "boilerplate" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Monad transformer stack order

---

## Agenda

- What problem do monads & monad transformers solve?
- "boilerplate" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Monad transformer stack order
- Type classes and transformer relationship

---

## Audience Presumptions (1/7)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | ... |
| 2+ arg function application | `func arg1 arg2` | ... |
| function composition | ... | ... |

---

## Audience Presumptions (2/7)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | ... |
| 2+ arg function application | `func arg1 arg2` | ... |
| function composition | `aToB >>> bToC` | ... |

---

## Audience Presumptions (3/7)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2` |
| function composition | `aToB >>> bToC` | ... |

---

## Audience Presumptions (4/7)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2` |
| function composition | `aToB >>> bToC` | `aToBoxB >=> bToBoxC` |

---

## Audience Presumptions (5/7)

| Description | No `Box` | With `Box` |
| - | - | - |
| 1 arg function application | `func arg` | `func <$> Box arg`<br />`Functor` |
| 2+ arg function application | `func arg1 arg2` | `func <$> Box arg1 <*> Box arg2`<br />`Applicative` |
| function composition | `aToB >>> bToC` | `aToBoxB >=> bToBoxC`<br />`Monad` |

---

## Audience Presumptions (6/7)

```
  do
a <- foo
b <- bar
pure $ a + b
```

---

## Audience Presumptions (7/7)

```
  do
bind foo (\a ->
  bind bar (\b ->
    pure $ a + b
  )
)
```

---

## What problem do monads solve?

```
yyyyyyyyyy computations
```

---

## What problem do monads solve?

```
sequential computations
```

---

## What problem do monads solve?

```
sequential computations
```

1. Do this

---

## What problem do monads solve?

```
sequential computations
```

1. Do this
2. Then do that

---

## What problem do monads solve?

```
sequential computations
```

1. Do this
2. Then do that
3. Then do something else

---

## What problem do monads solve?

```
sequential computations
```

1. Do this
2. Then do that
3. Then do something else
4. ...
---

## A Monadic Type Example: `Identity _`

---

## A Monadic Type Example: `Identity _`

A computation with compile-time newtype boxing and unboxing

---

## A Monadic Type Example: `Identity _`

- compile-time "boxy" function composition

---

## What problem do monads solve?

```
sequential computations
```

---

## What problem do monads solve?

```
"sequential-ish" computations
```

---

## A Monadic Type Example: `Either error _`

---

## A Monadic Type Example: `Either error _`

A short-circuiting computation where I care about errors

---

## A Monadic Type Example: `Either error _`

A short-circuiting computation where I care about errors

"Keep 'computing' until I am done or hit a `Left` case"

---

## A Monadic Type Example: `inputArg -> _`

---

## A Monadic Type Example: `inputArg -> _`

Compute something while having access to the function's argument at any point

---

## A Monadic Type Example: `state -> Tuple _ state`

---

## A Monadic Type Example: `state -> Tuple _ state`

Compute something while getting/setting/modifying a value on the side

---

## What problem do monads solve?

```
"sequential-ish" computations
```

---

## What problem do monads solve?

```
boilerplate-free "sequential-ish" computations
```

---

## How do monads solve it?

---

## How do monads solve it?

By hiding boilerplate via the `<-` in "do notation"

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

## Why use monad transformers?

---

## Why use monad transformers?

Answer
- Hide a lot of boilerplate with `<-`

---

## Why use monad transformers?

Answer
- <del>Hide a lot of boilerplate with `<-`</del>

---

## Why use monad transformers?

Answer
- <del>Hide a lot of boilerplate with `<-`</del>
- Add effects to existing computations

---

## Adding effects...

I want to augment a monadic computation...

---

## Adding effects...

I want to augment a monadic computation...

... with short-circuiting capabilities

---

## Adding effects...

I want to augment a monadic computation...

... to return 0, 1, or many outputs of the same type

---

## Adding effects...

I want to augment a monadic computation...

... to return an additional output besides the main one

---

## Adding effects...

I want to augment a monadic computation...

... to remove callback hell

---

## Why use monad transformers?

Answer
- <del>Hide a lot of boilerplate with `<-`</del>
- Add effects to existing computations
- Write more decoupled code

---

## Why use monad transformers?

Answer
- <del>Hide a lot of boilerplate with `<-`</del>
- Add effects to existing computations
- Write more decoupled code

---

## Why use monad transformers?

Answer
- <del>Hide a lot of boilerplate with `<-`</del>
- Add effects to existing computations
- Write more decoupled code
- Define interfaces (type classes) and implement them (transformers)

---

## Why use monad transformers?

Answer
- <del>Hide a lot of boilerplate with `<-`</del>
- Add effects to existing computations
- Write more decoupled code
- Define interfaces (type classes) and implement them (transformers)
  - Tagless Final Encoding

---

## Agenda

- What problem do monads & monad transformers solve?
- "boilerplate" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Monad transformer stack order
- Type classes and transformer relationship

---

## Agenda

- <del>What problem do monads & monad transformers solve?</del>
- "boilerplate" vs "do notation"
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Monad transformer stack order
- Type classes and transformer relationship

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