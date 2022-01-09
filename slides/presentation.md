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

## Presumptions (1/6)

1-arg function application, **NO** context:

```purescript
let
  function :: Int -> String
  function i = show i

  arg = 1 :: Int

  result :: String
  result = function arg

in result == "1"
```

---

## Presumptions (2/6)

1-arg function application, **WITH** a `Box` / context:

```purescript
data Box a = Box a

let
  function :: Int -> String
  function i = show i

  arg = Box 1 :: Box Int

  result :: Box String
  result = function arg

in result == Box "1"
```

If not, see the `Functor` type class.

---

## Presumptions (3/6)

2-arg function application, **NO**  `Box` / context:

```purescript
let
  function :: Int -> Int -> String
  function x y = show (i + y)

  argX = 1 :: Int
  argY = 2 :: Int

  result :: String
  result = function argX argY

in result == "3"
```

---

## Presumptions (4/6)

2-arg function application, **WITH** a `Box` / context:

```purescript
data Box a = Box a

let
  function :: Int -> Int -> String
  function x y = show (i + y)

  argX = Box 1 :: Box Int
  argY = Box 2 :: Box Int

  result :: Box String
  result = function <$> argX <*> argY

in result == Box "3"
```

If not, see the `Apply` type class.

---

## Presumptions (5/6)

1-arg function composition, **NO** `Box` / context:

```purescript
let
  intToString :: Int -> String
  intToString i = show i

  stringToBoolean :: String -> Boolean
  stringToBoolean s = s /= ""

  function :: Int -> Boolean
  function arg = stringToBoolean (intToString arg)

in (function 1) == true)
```

---

## Presumptions (6/6)

1-arg function composition, **WITH** a `Box` / context:

```purescript
data Box a = Box a

let
  intToBoxString :: Int -> Box String
  intToBoxString i = Box (show i)

  stringToBoxBoolean :: String -> Box Boolean
  stringToBoxBoolean s = Box (s /= "")

  function :: Int -> Box Boolean
  function arg = (intToString arg) >>= \s -> stringToBoolean s

in (function 1) == Box true
```

If not, see the `Bind`/`Monad` type class.

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
- "Fancy" function composition

---

## Common Monadic Types: `Either`

A short-circuiting computation where I care about errors

---

## Common Monadic Types: `Either`

A short-circuiting computation where I care about errors

"Keep 'computing' until I am done or hit a `Left` case"

---

## Common Monadic Types: `Effect error`

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
- Simulate algebraric effects (Final Tagless)

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