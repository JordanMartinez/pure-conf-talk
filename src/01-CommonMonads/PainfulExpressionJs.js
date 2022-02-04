#!/usr/bin/env node

const globalRef1 = 8;
const globalRef2 = 10;

main = function () {
  try {
    let x = 5;
    x = x + globalRef1;
    console.log(`x is ${x}`);
    if (x > globalRef2) throw new Error("x is too large");
    return "Everything is fine!";
  } catch (e) {
    console.log(e.message);
    return "What did you do!?";
  }
};

console.log(main());