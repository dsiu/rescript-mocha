type rec test_fn = Internal.Fn_Type.test<(~error: JsExn.t=?, unit) => unit, unit>
and hook = Internal.Fn_Type.fn_anon<(~error: JsExn.t=?, unit) => unit, unit>

let it: test_fn
let it_only: test_fn
let it_skip: test_fn
let before: hook
let after: hook
let beforeEach: hook
let afterEach: hook
