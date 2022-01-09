module CommonMonads.Either.Right where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import CommonMonads.Either.Right.Boilerplate (boilerplate)
import CommonMonads.Either.Right.DoNotation (doNotation)
import CommonMonads.Either.Right.NestedBind (nestedBind)

main :: Effect Unit
main = do
  log
    $ "Right Boilerplate: "
    <> show boilerplate
  log
    $ "Right Nested Bind: "
    <> show nestedBind
  log
    $ "Right Do Notation: "
    <> show doNotation
