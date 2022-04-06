type rec test_fn<'a> = Internal.Fn_Type.test<unit, Js.Promise.t<'a>>
and hook<'a> = Internal.Fn_Type.fn_anon<unit, Js.Promise.t<'a>>

let it = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Promise.it, description, ~timeout?, ~retries?, ~slow?, done_callback)

let it_only = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Promise.it_only, description, ~timeout?, ~retries?, ~slow?, done_callback)
let it_skip = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Promise.it_skip, description, ~timeout?, ~retries?, ~slow?, done_callback)
let before = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Promise.before, ~timeout?, ~retries?, ~slow?, done_callback)
let after = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Promise.after, ~timeout?, ~retries?, ~slow?, done_callback)
let beforeEach = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Promise.beforeEach, ~timeout?, ~retries?, ~slow?, done_callback)
let afterEach = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Promise.afterEach, ~timeout?, ~retries?, ~slow?, done_callback)
