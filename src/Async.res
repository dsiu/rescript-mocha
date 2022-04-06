type rec test_fn = Internal.Fn_Type.test<(~error: Js.Exn.t=?, unit) => unit, unit>
and hook = Internal.Fn_Type.fn_anon<(~error: Js.Exn.t=?, unit) => unit, unit>

let it = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAsync(Internal.Async.it, description, ~timeout?, ~retries?, ~slow?, done_callback)
let it_only = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAsync(Internal.Async.it_only, description, ~timeout?, ~retries?, ~slow?, done_callback)
let it_skip = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAsync(Internal.Async.it_skip, description, ~timeout?, ~retries?, ~slow?, done_callback)
let before = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAsyncAnon(Internal.Async.before, ~timeout?, ~retries?, ~slow?, done_callback)
let after = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAsyncAnon(Internal.Async.after, ~timeout?, ~retries?, ~slow?, done_callback)
let beforeEach = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAsyncAnon(Internal.Async.beforeEach, ~timeout?, ~retries?, ~slow?, done_callback)
let afterEach = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAsyncAnon(Internal.Async.afterEach, ~timeout?, ~retries?, ~slow?, done_callback)
