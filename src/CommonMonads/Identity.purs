module CommonMonads.Identity where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import CommonMonads.Identity.Boilerplate (boilerplate)
import CommonMonads.Identity.DoNotation (doNotation)
import CommonMonads.Identity.NestedBind (nestedBind)

main :: Effect Unit
main = do
  log
    $ "Identity - Boilerplate: "
    <> show boilerplate
  log
    $ "Identity - Nested Bind: "
    <> show nestedBind
  log
    $ "Identity - Do Notation: "
    <> show doNotation
