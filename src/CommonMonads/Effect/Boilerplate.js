"use strict";

// Unoptimized Effect code*
exports.boilerplate = () => {
  return (() => {
    const one = 1;
    return (() => {
      const two = 2;
      return (() => {
        return `${one + two}`;
      })();
    })();
  })();
};









// * PureScript uses "MagicDo" to
// unnests these nested `bind` calls.
// I've kept the nesting here
// to match what would otherwise be
// run for `Effect`.
// See `output/CommonMonads.Effect.DoNotation/index.js`
// for what PureScript actually outputs.
