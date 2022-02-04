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

- Why
- Intuition
- Use them now

---

## Agenda

- Why & What

---

## Agenda

- What and Why
- Thought Process

---

## Agenda

- What and Why
- Thought Process
- Usage & Mistakes

---

## Audience Presumptions

---

## What problem do monads solve?

---

## What problem do monads solve?

```
foo();
const bar = baz();
return true;
```

---

## What problem do monads solve?

```
foo
bar <- baz
pure true
```

---

## What problem do monads solve?

Statements vs Expression

---

## What problem do monads solve?

Analogy: Foreground vs Background

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

- `Identity`
- `Either error _`
- `Function input _`

---

## A Monadic Type Example: `Identity _`

---

## A Monadic Type Example: `Either error _`

---

## A Monadic Type Example: `inputArg -> _`

---

## What problem do monads solve?

---

## What problem do monads solve?

Via "do notation," monads provide a **syntax** for running "computations" in a sequential order.

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

## Why use monad transformers?

---

## Why use monad transformers?

- Add such "effects"

---

## Why use monad transformers?

- Add such "effects"
- Decouple code

---

## Agenda

- What and Why
- Thought Process
- Usage & Mistakes

---

## Agenda

- <del>What and Why</del>
- Thought Process
- Usage & Mistakes

---


## How do monad transformers solve these problems?

---

## How do monad transformers solve these problems?

By **simulating** these "effects"

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

`Tuple output state`

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

`globalRef -> state -> Effect (Tuple (Either Error Output) State)`

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

```
runExceptT (ExceptT ma) = ma
```

---

## Implementing `try ... catch`

```
-- throw
class Monad m <= MonadThrow e m | e -> m where
  throwError :: forall o. e -> m (Either e o)
  throwError e = pure $ Left e

-- try ... catch
class MonadThrow e m <= MonadError e m | e -> m where
  catchError :: forall o.
    m (Either e o) -> (e -> m (Either e o)) -> m (Either e o)
  catchError ma handler = do
    either <- ma
    case either of
      Left e -> handler e
      right -> pure right
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

```
runReaderT (ReaderT argToMa) arg = argToMa arg
```

---

## Implementing `global reference`

```
class MonadAsk globalRef m | globalRef -> m where
  ask :: m globalRef
  ask = (\arg -> pure arg)
```

(See also `MonadReader`)

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

```
runStateT (ReaderT sToMa) initialState = sToMa initialState
```

---

## Implementing `let x = 0; x += 1`

```
class MonadState s m | s -> m where
  get :: m state

  put :: state -> m Unit
```

(Implemented differently in real code)

---

## Agenda

- <del>What and Why</del>
- Thought Process
- Usage & Mistakes

---

## Agenda

- <del>What and Why</del>
- <del>Thought Process</del>
- Usage & Mistakes

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
foo :: Effect (Either String SomeValue)
foo = runExceptT do
  resp1 <- callApiRequest1
  resp2 <- callApiRequest2
  resp3 <- callApiRequest3
  pure $ ...
```

---

## Usage & Mistakes

```
foo :: Effect (Either String SomeValue)
foo = runExceptT program
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

`npm run tc-stack-order`

---

## Usage & Mistakes

`state -> monad (Tuple (Either err output) state)`

`state -> monad (Either err (Tuple output state)`

---

## Usage & Mistakes

`Tuple (Left error) state`
vs
`Left error`

---

## Usage & Mistakes

`forall monad. ....`

---

## Usage & Mistakes

`npm run tc-different-monads`

---

## Agenda

- <del>What and Why</del>
- <del>Thought Process</del>
- Usage & Mistakes

---

## Agenda

- <del>What and Why</del>
- <del>Thought Process</del>
- <del>Usage & Mistakes</del>

---

## Where do we go from here?

---

## Where do we go from here?

- https://github.com/JordanMartinez/pure-conf-talk
  - `slides/CheatSheet.md`
      - Monad Transformers <-> Concrete types
      - Stack Order

---

## Where do we go from here?

- https://github.com/JordanMartinez/pure-conf-talk
  - `slides/CheatSheet.md`
      - Monad Transformers <-> Concrete types
      - Stack Order
  - `src` directory - each transformer: boilerplate, nested bind, do notation, transformer

---

## Where do we go from here?

- https://github.com/JordanMartinez/pure-conf-talk
  - `slides/CheatSheet.md`
      - Monad Transformers <-> Concrete types
      - Stack Order
  - `src` directory - each transformer: boilerplate, nested bind, do notation, transformer
  - Run examples of transformers (`package.json` scripts)

---

## Where do we go from here?

- https://github.com/JordanMartinez/pure-conf-talk
  - `slides/CheatSheet.md`
      - Monad Transformers <-> Concrete types
      - Stack Order
  - `src` directory - each transformer: boilerplate, nested bind, do notation, transformer
  - Run examples of transformers (`package.json` scripts)
- Explore the Capability Pattern

---

## Summary

- Expressions, not statements

---

## Summary

- Expressions, not statements
- Add effects via transformers

---

## Summary

- Expressions, not statements
- Add effects via transformers
- Stack Order & `forall monad`

---

## Contact Me

Discord: @JordanMartinez
GitHub: @JordanMartinez
