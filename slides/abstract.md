# Abstract

Title: "Using Monad Transformers without understanding them"

Do you understand Monads and "do notation," but still do not understand Monad Transformers? Do you want to use a framework or library, but it has been scaring you off because it uses a monad transformer? Then this talk is for you.

This talk answers two questions:
- what problem do monad transformers solve?
- how do I use monad transformers to solve that problem?

This talk will
- show examples of common monad transformers and their equivalent "untransformed" versions
- show how to "sugar" a concrete type into a monad transformer
- explain why the order of monad transformers matter
- show how to write programs using monad transformers and their corresponding type classes

This talk will not explain why monad transformers actually work. But, it will be easier for you to learn why they work after watching this talk.

By the end of this talk, you will
- understand when to use transformers
- be able to use `ExceptT`, `ReaderT`, and `StateT`
- have an intuition for how "Tagless Final" works
