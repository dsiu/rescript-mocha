let describe = Mocha.describe
open Async

describe("Async", () => {
  /* Calls given function after a small delay */
  let delay = fn => Js.Global.setTimeout(() => fn(), 300) |> ignore

  describe("Success", () =>
    it("should be successful", done_ => Js.Global.setTimeout(() => {
        Assert.equal(3, 3)
        done_()
      }, 500) |> ignore)
  )

  describe("Error", () =>
    it_skip("should error out", done_ => {
      let error: Js.Exn.t = %raw(` new Error("error out") `)
      done_(~error, ())
    })
  )

  describe("Hooks", () => {
    let hooks = ref({
      "before": false,
      "beforeEach": 0,
      "after": false,
      "afterEach": 0,
    })

    before(done_ =>
      delay(() => {
        hooks := {"before": true, "beforeEach": 0, "after": false, "afterEach": 0}
        done_()
      })
    )

    beforeEach(done_ =>
      delay(() => {
        let hooks' = hooks.contents
        hooks :=
          {
            "before": hooks'["before"],
            "beforeEach": hooks'["beforeEach"] + 1,
            "after": hooks'["after"],
            "afterEach": hooks'["afterEach"],
          }
        done_()
      })
    )

    it("is the first test", done_ => done_())
    it("is the second test", done_ => done_())
    it("is the third test", done_ => done_())

    afterEach(done_ =>
      delay(() => {
        let hooks' = hooks.contents
        hooks :=
          {
            "before": hooks'["before"],
            "beforeEach": hooks'["beforeEach"],
            "after": hooks'["after"],
            "afterEach": hooks'["afterEach"] + 1,
          }
        done_()
      })
    )

    after(done_ =>
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
        done_()
      })
    )
  })

  describe("Timeout", () => {
    it_skip("should time out", ~timeout=50, done_ =>
      Js.Global.setTimeout(() => done_(), 51) |> ignore
    )

    it("should not time out", ~timeout=50, done_ =>
      Js.Global.setTimeout(() => done_(), 40) |> ignore
    )
  })

  describe("Retries", () => {
    let retry_count = ref(0)
    it("should succeed", ~retries=2, done_ => {
      retry_count := retry_count.contents + 1
      Assert.ok(retry_count.contents == 1)
      done_()
    })

    it_skip("should fail", ~retries=3, done_ => {
      retry_count := retry_count.contents + 1
      Assert.ok(retry_count.contents == 6)
      done_()
    })
  })

  describe("Slow", () =>
    it("should be considered slow", ~slow=50, done_ =>
      Js.Global.setTimeout(() => done_(), 40) |> ignore
    )
  )
})
