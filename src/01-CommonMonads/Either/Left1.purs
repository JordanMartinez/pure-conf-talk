module MonadTransformers.Either.Left1 where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import CommonMonads.Either.Left1.Boilerplate (boilerplate)
import CommonMonads.Either.Left1.DoNotation (doNotation)
import CommonMonads.Either.Left1.NestedBind (nestedBind)

main :: Effect Unit
main = do
  log
    $ "Left1 Boilerplate: "
    <> show boilerplate
  log
    $ "Left1 Nested Bind: "
    <> show nestedBind
  log
    $ "Left1 Do Notation: "
    <> show doNotation
