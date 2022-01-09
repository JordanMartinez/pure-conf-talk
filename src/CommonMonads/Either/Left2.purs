module CommonMonads.Either.Left2 where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import CommonMonads.Either.Left2.Boilerplate (boilerplate)
import CommonMonads.Either.Left2.DoNotation (doNotation)
import CommonMonads.Either.Left2.NestedBind (nestedBind)

main :: Effect Unit
main = do
  log
    $ "Left2 Boilerplate: "
    <> show boilerplate
  log
    $ "Left2 Nested Bind: "
    <> show nestedBind
  log
    $ "Left2 Do Notation: "
    <> show doNotation
