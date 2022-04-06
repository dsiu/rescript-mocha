type rec test_fn = Internal.Fn_Type.test<unit, unit>
and hook = Internal.Fn_Type.fn_anon<unit, unit>

let describe: test_fn
let describe_only: test_fn
let describe_skip: test_fn
let it: test_fn
let it_only: test_fn
let it_skip: test_fn
let before: hook
let after: hook
let beforeEach: hook
let afterEach: hook
