# @dsiu/rescript-mocha

ReScript bindings for [Mocha](https://mochajs.org/) testing framework. Updated for ReScript v12.

## Install 

```bash
npm install @dsiu/rescript-mocha mocha --save-dev 
```

Add to `rescript.json`:

```json
{
  "bs-dependencies": [
    "@dsiu/rescript-mocha"
  ]
}
```

## Usage

### Synchronous Tests

```rescript
open RescriptMocha.Mocha
module Assert = RescriptMocha.Assert

describe("Array.map", () => {
  it("should map the values", () =>
    Assert.deepEqual(Array.map([1, 2, 3], i => i * 2), [2, 4, 6])
  )

  it("should work with an empty array", () =>
    Assert.deepEqual(Array.map([], i => i * 2), [])
  )
})
```

### Promise-based Async Tests

```rescript
open RescriptMocha.Promise_

describe("Async tests", () => {
  it("should resolve after delay", () => {
    Promise.make((resolve, _reject) => {
      setTimeout(() => resolve(42), 100)->ignore
    })->Promise.then(value => {
      Assert.equal(value, 42)
      Promise.resolve()
    })
  })
})
```

### Callback-based Async Tests

```rescript
open RescriptMocha.Async

describe("Callback tests", () => {
  it("should call done when complete", done => {
    setTimeout(() => done(), 100)->ignore
  })
})
```

## API

- **`Mocha`** - Synchronous `describe`, `it`, `before`, `after`, `beforeEach`, `afterEach`
- **`Promise_`** - Promise-based async versions
- **`Async`** - Callback-based async versions (done-style)
- **`Assert`** - Node.js assert module bindings

Each module also provides `_only` and `_skip` variants (e.g., `it_only`, `describe_skip`).

```

## License and Credits

All code is licensed as MIT. See [LICENSE](LICENSE).

This project is a fork of [rescript-mocha](https://github.com/TheSpyder/rescript-mocha) by [TheSpyder](https://github.com/TheSpyder), which in turn was forked from [bs-mocha](https://github.com/reasonml-community/bs-mocha) after it was abandoned.
