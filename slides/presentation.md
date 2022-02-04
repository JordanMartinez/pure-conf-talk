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
- How?

---

## Agenda

- Why: What problem do monads & monad transformers solve?

---

## Agenda

- Why: What problem do monads & monad transformers solve?
- How: Reimplementing monad transformers
  - `ExceptT`
  - `ReaderT`
  - `StateT`

---

## Agenda

- Why: What problem do monads & monad transformers solve?
- How: Reimplementing monad transformers
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Usage & Mistakes: Stacks and stack order

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
bind foo (\a ->
  bind bar (\b ->
    pure $ a + b
  )
)
```

---

## What problem do monads solve?

---

## What problem do monads solve?

Replacing procedural statements with sequential expressions

---

## What problem do monads solve?

Foreground vs Background

---

## What problem do monads solve?

![Foreground vs Background](./foreground-background.jpg)

---

## What problem do monads solve?

Foreground = "do notation" syntax

---

## What problem do monads solve?

Background = "`bind` implementation"

---

## What problem do monads solve?

Foreground = sequential computation

---

## What problem do monads solve?

Background = boilerplate-y boxing and unboxing

---

## Common Monadic Types

- `Either error _`
- `Function input _`
- `state -> Tuple _ state`
- `Effect _`

---

## A Monadic Type Example: `Identity _`

---

## A Monadic Type Example: `Either error _`

---

## A Monadic Type Example: `inputArg -> _`

---

## A Monadic Type Example: `state -> Tuple _ state`

---

## A Monadic Type Example: `Effect _`

---

## What problem do monads solve?

---

## What problem do monads solve?

Via "do notation," monads provide a **syntax** for running "computations" in a sequential order.

---

## What problem do monads solve?

Replace statements...

```
foo();
const bar = baz();
return true;
```

---

## What problem do monads solve?

... with expressions

```
foo
bar <- baz
pure true
```

---

## What problem do monads NOT solve?


---

## What problem do monads NOT solve?

```
try {
  throw new Error("My bad!");
  console.log("I never get printed! 😭");
} catch (e) {
  console.log("Something went wrong...");
}
```

---

## What problem do monads NOT solve?

```
const x = "Hello World!";
const f = function () {
  console.log(x);
};
f();
```

---

## What problem do monads NOT solve?

```
let x = 1;
x += 1;
x = 5;
```

---

How do we implement these features?

---

Monad Transformers

---

## How do monad transformers solve these problems?

---

## How do monad transformers solve these problems?

By **simulating** these "effects"

---

## Why use monad transformers?

---

## Why use monad transformers?

- Add such "effects" to sequential computations

---

## Why use monad transformers?

- Add such "effects" to sequential computations
- Write more decoupled code

---

## Agenda

- Why: What problem do monads & monad transformers solve?
- How: Reimplementing monad transformers
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Usage & Mistakes: Stacks and stack order

---

## Agenda

- <del>Why: What problem do monads & monad transformers solve?</del>
- How: Reimplementing monad transformers
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Usage & Mistakes: Stacks and stack order

---

## Monad Transformers

**Simulate** effects

---

## Simulating Effects

`try ... catch`

---

## Simulating Effects

`try ... catch`

`Either`

---

## Simulating Effects

`global reference`

---

## Simulating Effects

`global reference`

`\globalRef -> ...`

---

## Simulating Effects

`let x = 0; x += 1;`

---

## Simulating Effects

`let x = 0; x += 1;`

`\oldState -> Tuple output (oldState + 1)`

---

## Simulating Effects

---

## Simulating Effects

Have you seen that boilerplate?

---

## Simulating Effects with Boilerplate

`try ... catch`

`Either`

---

## Simulating Effects with Boilerplate

`global reference`

`\globalRef -> ...`

---

## Simulating Effects with Boilerplate

`let x = 0; x += 1;`

`\oldState -> Tuple output (oldState + 1)`

---

## Simulating Effects with Boilerplate

```
try {
  let x = 5;
  x = x + globalRef1;
  console.log(`x is ${x}`);
  if (x > globalRef2) throw new Error("x is too large");
  return "Everything is fine!";
} catch (e) {
  console.log(e);
  return "What did you do!?";
}
```

`\globalRef -> state -> Effect (Tuple (Either Error Output) State)`

---

## Simulating Effects with Boilerplate

<pre><code>
.·´¯`(>▂<)´¯`·.
</code></pre>

---

## Simulating Effects with Boilerplate

If only...

---

## Simulating Effects with Boilerplate

But wait! Don't monads...?

---

## Simulating Effects with Boilerplate

Can we transform monads...?

---

## Simulating Effects with Boilerplate

---

## Implementing `try ... catch`

`monad output`

---

## Implementing `try ... catch`

`monad (Either error output)`

---

## Implementing `try ... catch`

```
newtype ExceptT error monad output =
  ExceptT (monad (Either error output))
```

---

## Implementing `try ... catch`

```
-- throw
throwError :: forall m e o. e -> m (Either e o)

-- try ... catch
catchError :: forall m e o. m (Either e o) -> (e -> m (Either e o)) -> m (Either e o)
```

---

## Implementing `global reference`

`monad output`

---

## Implementing `global reference`

`globalRef -> monad output`

---

## Implementing `global reference`

```
newtype ReaderT globalRef monad output =
  ReaderT (globalRef -> monad output)
```

---

## Implementing `global reference`

```
ask :: forall m globalRef. m globalRef
```

---

## Implementing `let x = 0; x += 1`

`monad output`

---

## Implementing `let x = 0; x += 1`

`state -> monad (Tuple output state)`

---

## Implementing `let x = 0; x += 1`

```
newtype StateT state monad output =
  StateT (state -> monad (Tuple output state))
```

---

## Implementing `let x = 0; x += 1`

```
get :: forall m state. m state

put :: forall m state. state -> m Unit
```

---

## Agenda

- <del>Why: What problem do monads & monad transformers solve?</del>
- How: Reimplementing monad transformers
  - `ExceptT`
  - `ReaderT`
  - `StateT`
- Usage & Mistakes: Stacks and stack order

---

## Agenda

- <del>Why: What problem do monads & monad transformers solve?</del>
- <del>How: Reimplementing monad transformers</del>
  - <del>`ExceptT`</del>
  - <del>`ReaderT`</del>
  - <del>`StateT`</del>
- Usage & Mistakes: Stacks and stack order

---

## Usage & Mistakes

---

## Usage & Mistakes

Don't!

---

## Usage & Mistakes

One Transformer?

---

## Usage & Mistakes

```
foo :: Effect Unit
foo =
  result <- runExceptT do
    resp1 <- callApiRequest1
    resp2 <- callApiRequest2
    resp3 <- callApiRequest3
    pure $ ...
  case result of
    Left e -> ...
    Right a -> ...
```

---

## Usage & Mistakes

```
foo :: Effect Unit
foo = runExceptT program do
  where
  program
    :: forall m
     . MonadError String m
    => m SomeValue
  program = do
    resp1 <- callApiRequest1
    resp2 <- callApiRequest2
    resp3 <- callApiRequest3
    pure $ ...
```

---

## Usage & Mistakes

Multiple Transformers?

---

## Usage & Mistakes

Stack and Stack Order

---

## Usage & Mistakes

`forall monad. ....`

---

## Agenda

- <del>Why: What problem do monads & monad transformers solve?</del>
- <del>How: Reimplementing monad transformers</del>
  - <del>`ExceptT`</del>
  - <del>`ReaderT`</del>
  - <del>`StateT`</del>
- Usage & Mistakes: Stacks and stack order

---

## Agenda

- <del>Why: What problem do monads & monad transformers solve?</del>
- <del>How: Reimplementing monad transformers</del>
  - <del>`ExceptT`</del>
  - <del>`ReaderT`</del>
  - <del>`StateT`</del>
- <del>Usage & Mistakes: Stacks and stack order</del>

---

## Where do we go from here?

- https://github.com/JordanMartinez/pure-conf-talk)
  - Desugar transformers to concrete types
  - Sugar concrete types to transformers
  - See each syntax version for each transformer
  - Run simple examples of transformers
- Explore the Capability Pattern
