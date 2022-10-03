# pure-conf-talk

Slides and other goodies for my PureConf 2022 talk: "**Using Monad Transformers without understanding them**"

See
- [Video](https://hasgeek.com/FP-Juspay/pureconf/schedule/using-monad-transformers-without-understanding-them-JAFRaaAiVQBaBfVX3Yuruv)
- [Slides](./slides/presentation.pdf)
- [Cheatsheet](./slides/Cheatsheet.md) - things I didn't cover in my talk but are still useful to know
- the [src](./src) directory
  - transformer implicit - using a transformer and its corresponding functions (i.e. production code)
  - transformer explicit - same as "transformer implicit" but showing what boxes occur on right-hand side of `<-`
  - do notation - same as "transformer explicit" but without using the transformer
  - nested bind - desugared "do notation" to nested binds
  - boilerplate - same as "nested bind" but showing `bind` implementation / what actually gets run
- the `scripts` in [package.json](./package.json)
