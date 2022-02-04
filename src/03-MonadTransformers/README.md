# Monad Transformers

Each transformer here has 5 versions (less magical first, most magical last):
- Boilerplate - what one would ultimately write if "do notation" didn't exist
- NestedBind - desugaring "do notation" into nested `bind` calls
- DoNotation - do notation without using the transformer
- Trasnformer - do notation while explicitly using the transformer
- Typeclass - do notation while implicitly using the transformer via a type class

Each example can be run via
```sh
npm run mt-right
npm run mt-left
npm run mt-readert
npm run mt-statet
```
