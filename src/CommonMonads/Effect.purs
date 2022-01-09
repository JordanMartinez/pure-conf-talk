module CommonMonads.Effect where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Effect.Unsafe (unsafePerformEffect)
import CommonMonads.Effect.Boilerplate (boilerplate)
import CommonMonads.Effect.DoNotation (doNotation)
import CommonMonads.Effect.NestedBind (nestedBind)

main :: Effect Unit
main = do
  log
    $ "Effect - Boilerplate: "
    <> (unsafePerformEffect boilerplate)
  log
    $ "Effect - Nested Bind: "
    <> (unsafePerformEffect nestedBind)
  log
    $ "Effect - Do Notation: "
    <> (unsafePerformEffect doNotation)
