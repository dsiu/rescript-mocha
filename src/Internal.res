type rec mocha
and done_callback = Js.Nullable.t<Js.Exn.t> => unit
and test_fn<'arg, 'result> = (string, @this (mocha, 'arg) => 'result) => unit

module Fn_Type = {
  /* Internal representation of mocha test functions */
  type rec internal_callback = (
    . string,
    @this (mocha, done_callback) => unit,
  ) => unit
  and internal_callback_anon = (. @this (mocha, done_callback) => unit) => unit
  /* Internal representation with `unit => unit` callback (special-cased to
   ensure compiled JS is a nullary function) */
  and internal_nullary<'result> = (. string, @this (mocha => 'result)) => unit
  and internal_anon<'result> = (. @this (mocha => 'result)) => unit
  /* Nicer representation of mocha test functions */
  and fn_anon<'arg, 'result> = (
    ~timeout: int=?,
    ~retries: int=?,
    ~slow: int=?,
    'arg => 'result,
  ) => unit
  /* For `describe` and `it`, which require a description */
  and test<'arg, 'result> = (
    string,
    ~timeout: int=?,
    ~retries: int=?,
    ~slow: int=?,
    'arg => 'result,
  ) => unit
}

/* Mocha bindings on `this` for `describe` and `it` functions */
module This = {
  @send external timeout: (mocha, int) => unit = "timeout"
  @send external retries: (mocha, int) => unit = "retries"
  @send external slow: (mocha, int) => unit = "slow"
  @send external skip: (mocha, unit) => unit = "skip"
}

module Sync = {
  @val
  external describe: (. string, @this (mocha => unit)) => unit = "describe"
  @val
  external describe_only: (. string, @this (mocha => unit)) => unit = "describe.only"
  @val
  external describe_skip: (. string, @this (mocha => unit)) => unit = "describe.skip"
  @val
  external it: (. string, @this (mocha => unit)) => unit = "it"
  @val
  external it_only: (. string, @this (mocha => unit)) => unit = "it.only"
  @val
  external it_skip: (. string, @this (mocha => unit)) => unit = "it.skip"
  @val
  external before: (. @this (mocha => unit)) => unit = "before"
  @val
  external after: (. @this (mocha => unit)) => unit = "after"
  @val
  external beforeEach: (. @this (mocha => unit)) => unit = "beforeEach"
  @val
  external afterEach: (. @this (mocha => unit)) => unit = "afterEach"
}

module Async = {
  @val
  external it: (. string, @this (mocha, done_callback) => unit) => unit = "it"
  @val
  external it_only: (. string, @this (mocha, done_callback) => unit) => unit =
    "it.only"
  @val
  external it_skip: (. string, @this (mocha, done_callback) => unit) => unit =
    "it.skip"
  @val
  external before: (. @this (mocha, done_callback) => unit) => unit = "before"
  @val
  external after: (. @this (mocha, done_callback) => unit) => unit = "after"
  @val
  external beforeEach: (. @this (mocha, done_callback) => unit) => unit = "beforeEach"
  @val
  external afterEach: (. @this (mocha, done_callback) => unit) => unit = "afterEach"
}

module Promise = {
  @val
  external it: (. string, @this (mocha => Js.Promise.t<'a>)) => unit = "it"
  @val
  external it_only: (. string, @this (mocha => Js.Promise.t<'a>)) => unit = "it.only"
  @val
  external it_skip: (. string, @this (mocha => Js.Promise.t<'a>)) => unit = "it.skip"
  @val
  external before: (. @this (mocha => Js.Promise.t<'a>)) => unit = "before"
  @val
  external after: (. @this (mocha => Js.Promise.t<'a>)) => unit = "after"
  @val
  external beforeEach: (. @this (mocha => Js.Promise.t<'a>)) => unit = "beforeEach"
  @val
  external afterEach: (. @this (mocha => Js.Promise.t<'a>)) => unit = "afterEach"
}

%%private(
  let applyOptions = (~timeout=?, ~retries=?, ~slow=?, mocha) => {
    switch timeout {
    | Some(milliseconds) => This.timeout(mocha, milliseconds)
    | None => ()
    }
    switch retries {
    | Some(max_retries) => This.retries(mocha, max_retries)
    | None => ()
    }
    switch slow {
    | Some(milliseconds) => This.slow(mocha, milliseconds)
    | None => ()
    }
  }
)
/* Wraps the options normally set with `this` in mocha and makes them optional arguments */
let make = (
  fn,
  description,
  ~timeout=?,
  ~retries=?,
  ~slow=?,
  done_callback,
) =>
  fn(.description, @this mocha => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)
    done_callback()
  })
let makeAnon = (
  fn,
  ~timeout=?,
  ~retries=?,
  ~slow=?,
  done_callback,
) =>
  fn(.@this mocha => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)
    done_callback()
  })

let makeAsync = (
  fn,
  description,
  ~timeout=?,
  ~retries=?,
  ~slow=?,
  done_callback,
) =>
  fn(.description, @this (mocha, done_callback') => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)

    let done_fn = (~error=?, ()) => done_callback'(Js.Nullable.fromOption(error))
    done_callback(done_fn)
  })

let makeAsyncAnon = (fn, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  fn(.@this (mocha, done_callback') => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)

    let done_fn = (~error=?, ()) => done_callback'(Js.Nullable.fromOption(error))
    done_callback(done_fn)
  })
