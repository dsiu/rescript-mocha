type rec test_fn<'a> = Internal.Fn_Type.test<unit, Js.Promise.t<'a>>
and hook<'a> = Internal.Fn_Type.fn_anon<unit, Js.Promise.t<'a>>

let it: test_fn<'a>
let it_only: test_fn<'a>
let it_skip: test_fn<'a>
let before: hook<'a>
let after: hook<'a>
let beforeEach: hook<'a>
let afterEach: hook<'a>
