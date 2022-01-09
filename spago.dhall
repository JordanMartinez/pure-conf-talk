{ name = "my-project"
, dependencies =
  [ "console"
  , "effect"
  , "either"
  , "identity"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "random"
  , "transformers"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
