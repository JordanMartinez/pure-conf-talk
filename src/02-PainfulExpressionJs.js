#!/usr/bin/env node

const config = {
  age: 8,
  max: 10,
};

main = function () {
  try {
    let x = 5;
    x = x + config.age;
    console.log(`x is ${x}`);
    if (x > config.max) throw new Error("x is too large");
    return "Everything is fine!";
  } catch (e) {
    console.log(e.message);
    return "What did you do!?";
  }
};

console.log(main());