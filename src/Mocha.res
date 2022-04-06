type rec test_fn = Internal.Fn_Type.test<unit, unit>
and hook = Internal.Fn_Type.fn_anon<unit, unit>

let describe: test_fn = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Sync.describe, description, ~timeout?, ~retries?, ~slow?, done_callback)
let describe_only: test_fn = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Sync.describe_only, description, ~timeout?, ~retries?, ~slow?, done_callback)
let describe_skip: test_fn = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Sync.describe_skip, description, ~timeout?, ~retries?, ~slow?, done_callback)

let it = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Sync.it, description, ~timeout?, ~retries?, ~slow?, done_callback)
let it_only = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Sync.it_only, description, ~timeout?, ~retries?, ~slow?, done_callback)
let it_skip = (description, ~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.make(Internal.Sync.it_skip, description, ~timeout?, ~retries?, ~slow?, done_callback)
let before = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Sync.before, ~timeout?, ~retries?, ~slow?, done_callback)
let after = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Sync.after, ~timeout?, ~retries?, ~slow?, done_callback)
let beforeEach = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Sync.beforeEach, ~timeout?, ~retries?, ~slow?, done_callback)
let afterEach = (~timeout=?, ~retries=?, ~slow=?, done_callback) =>
  Internal.makeAnon(Internal.Sync.afterEach, ~timeout?, ~retries?, ~slow?, done_callback)
