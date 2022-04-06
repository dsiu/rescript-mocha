let (describe, describe_skip) = {
  open Mocha
  (describe, describe_skip)
}
open Promise

exception RejectedError(string)

describe("Promise", () => {
  let empty = () => Js.Promise.make((~resolve, ~reject as _) => resolve(. true))

  /* Calls given function after a small delay */
  let delay = fn =>
    Js.Promise.make((~resolve, ~reject as _) => Js.Global.setTimeout(() => {
        fn()
        resolve(. true)
      }, 300) |> ignore)

  /* Rejects the promise after a small delay */
  let delay_reject = () =>
    Js.Promise.make((~resolve as _, ~reject) =>
      Js.Global.setTimeout(
        () => reject(. RejectedError("promise successfully rejected")),
        300,
      ) |> ignore
    )

  describe("Success", () => it("should be successful", () => delay(() => Assert.equal(3, 3))))

  describe_skip("Error", () => it("should error out", () => delay_reject()))

  describe("Hooks", () => {
    let hooks = ref({
      "before": false,
      "beforeEach": 0,
      "after": false,
      "afterEach": 0,
    })

    before(() =>
      delay(() => hooks := {"before": true, "beforeEach": 0, "after": false, "afterEach": 0})
    )

    beforeEach(() =>
      delay(() => {
        let hooks' = hooks.contents
        hooks :=
          {
            "before": hooks'["before"],
            "beforeEach": hooks'["beforeEach"] + 1,
            "after": hooks'["after"],
            "afterEach": hooks'["afterEach"],
          }
      })
    )

    it("is the first test", () => empty())
    it("is the second test", () => empty())
    it("is the third test", () => empty())

    afterEach(() =>
      delay(() => {
        let hooks' = hooks.contents
        hooks :=
          {
            "before": hooks'["before"],
            "beforeEach": hooks'["beforeEach"],
            "after": hooks'["after"],
            "afterEach": hooks'["afterEach"] + 1,
          }
      })
    )

    after(() =>
      delay(() => {
        let hooks' = hooks.contents
        hooks :=
          {
            "before": hooks'["before"],
            "beforeEach": hooks'["beforeEach"],
            "after": true,
            "afterEach": hooks'["afterEach"],
          }

        /* TODO: this is pretty ugly, caused by (facebook/reason issue #2108) */
        let hooks'' = hooks.contents
        Assert.ok(hooks''["before"])
        Assert.equal(hooks''["beforeEach"], 3)
        Assert.equal(hooks''["afterEach"], 3)
        Assert.ok(hooks''["after"])
      })
    )
  })

  describe("Timeout", () => {
    it_skip("should time out", ~timeout=50, () =>
      Js.Promise.make((~resolve, ~reject as _) =>
        Js.Global.setTimeout(() => resolve(. true), 51) |> ignore
      )
    )

    it("should not time out", ~timeout=50, () =>
      Js.Promise.make((~resolve, ~reject as _) =>
        Js.Global.setTimeout(() => resolve(. true), 40) |> ignore
      )
    )
  })

  describe("Retries", () => {
    let retry_count = ref(0)
    it("should succeed", ~retries=2, () =>
      Js.Promise.make((~resolve, ~reject as _) => {
        retry_count := retry_count.contents + 1
        Assert.ok(retry_count.contents == 1)
        resolve(. true)
      })
    )

    it_skip("should fail", ~retries=3, () =>
      Js.Promise.make((~resolve, ~reject as _) => {
        retry_count := retry_count.contents + 1
        Assert.ok(retry_count.contents == 6)
        resolve(. true)
      })
    )
  })

  describe("Slow", () =>
    it("should be considered slow", ~slow=50, () =>
      Js.Promise.make((~resolve, ~reject as _) =>
        Js.Global.setTimeout(() => resolve(. true), 60) |> ignore
      )
    )
  )
})
