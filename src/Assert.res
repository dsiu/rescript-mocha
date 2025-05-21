module Labels = {
  @module("assert")
  external equal: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit = "equal"
  @module("assert")
  external notEqual: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit = "notEqual"

  @module("assert")
  external deepEqual: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit = "deepEqual"
  @module("assert")
  external notDeepEqual: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit = "notDeepEqual"

  @module("assert")
  external strictEqual: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit = "strictEqual"
  @module("assert")
  external notStrictEqual: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit =
    "notStrictEqual"

  @module("assert")
  external deepStrictEqual: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit =
    "deepStrictEqual"
  @module("assert")
  external notDeepStrictEqual: (~actual: 'a, ~expected: 'a, ~message: string=?) => unit =
    "notDeepStrictEqual"

  @module("assert") external ifError: (~value: 'a) => unit = "ifError"

  @module("assert")
  external throws: (~block: 'a => 'b, ~error: JsExn.t, ~message: string=?) => unit = "throws"
  @module("assert")
  external doesNotThrow: (~block: 'a => 'b, ~error: JsExn.t, ~message: string=?) => unit =
    "doesNotThrow"

  @module("assert") external ok: (~value: 'a) => unit = "ok"
  @module("assert") external fail: (~message: 'a) => unit = "fail"
  @module("assert")
  external fail': (
    ~actual: 'a,
    ~expected: 'a,
    ~message: string=?,
    ~operator: string=?,
    ~stackStartFn: 'b => 'c=?,
  ) => unit = "fail"
}

let equal = (~message=?, actual, expected) => Labels.equal(~actual, ~expected, ~message?)
and notEqual = (~message=?, actual, expected) => Labels.notEqual(~actual, ~expected, ~message?)

let deepEqual = (~message=?, actual, expected) => Labels.deepEqual(~actual, ~expected, ~message?)
and notDeepEqual = (~message=?, actual, expected) =>
  Labels.notDeepEqual(~actual, ~expected, ~message?)

let deepStrictEqual = (~message=?, actual, expected) =>
  Labels.deepStrictEqual(~actual, ~expected, ~message?)
and notDeepStrictEqual = (~message=?, actual, expected) =>
  Labels.notDeepStrictEqual(~actual, ~expected, ~message?)

let strictEqual = (~message=?, actual, expected) =>
  Labels.strictEqual(~actual, ~expected, ~message?)
and notStrictEqual = (~message=?, actual, expected) =>
  Labels.notStrictEqual(~actual, ~expected, ~message?)

let ifError = value => Labels.ifError(~value)

let ok = value => Labels.ok(~value)
and fail = message => Labels.fail(~message)
and fail' = (~message=?, ~operator=?, ~stackStartFn=?, actual, expected) =>
  Labels.fail'(~actual, ~expected, ~message?, ~operator?, ~stackStartFn?)

let throws = (~message=?, block, error) => Labels.throws(~block, ~error, ~message?)
and doesNotThrow = (~message=?, block, error) => Labels.doesNotThrow(~block, ~error, ~message?)
