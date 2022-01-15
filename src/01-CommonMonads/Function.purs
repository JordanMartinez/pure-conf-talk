module CommonMonads.Function where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import CommonMonads.Function.Boilerplate (boilerplate)
import CommonMonads.Function.DoNotation (doNotation)
import CommonMonads.Function.NestedBind (nestedBind)

main :: Effect Unit
main = do
  log
    $ "Function - Boilerplate: "
    <> (boilerplate 1)
  log
    $ "Function - Nested Bind: "
    <> (nestedBind 1)
  log
    $ "Function - Do Notation: "
    <> (doNotation 1)
