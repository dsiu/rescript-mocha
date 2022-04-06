
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
  external throws: (~block: 'a => 'b, ~error: Js.Exn.t, ~message: string=?) => unit = "throws"
  @module("assert")
  external doesNotThrow: (~block: 'a => 'b, ~error: Js.Exn.t, ~message: string=?) => unit =
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
