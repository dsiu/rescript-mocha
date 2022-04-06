let (it', it_skip') = {
  open Async
  (it, it_skip)
}
open Mocha
open Belt

describe("Mocha", () => {
  describe("Success", () =>
    describe("List", () => {
      it("should map the values", () =>
        Assert.deepEqual(Array.map([1, 2, 3], (i) => i * 2), [2, 4, 6])
      )

      it("should work with an empty list", () => Assert.deepEqual(Array.map([], (i) => i * 2), []))
    })
  )

  describe_skip("Error", () => it("should fail", () => Assert.equal(1, 2)))

  describe("Hooks", () => {
    let hooks = ref({
      "before": false,
      "beforeEach": 0,
      "after": false,
      "afterEach": 0,
    })

    before(() => hooks := {"before": true, "beforeEach": 0, "after": false, "afterEach": 0})

    beforeEach(() => {
      let hooks' = hooks.contents
      hooks :=
        {
          "before": hooks'["before"],
          "beforeEach": hooks'["beforeEach"] + 1,
          "after": hooks'["after"],
          "afterEach": hooks'["afterEach"],
        }
    })

    it("is the first test", () => ())
    it("is the second test", () => ())
    it("is the third test", () => ())

    afterEach(() => {
      let hooks' = hooks.contents
      hooks :=
        {
          "before": hooks'["before"],
          "beforeEach": hooks'["beforeEach"],
          "after": hooks'["after"],
          "afterEach": hooks'["afterEach"] + 1,
        }
    })

    after(() => {
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
  })

  describe("Timeout", ~timeout=50, () => {
    it_skip'("should time out", done_ => Js.Global.setTimeout(() => done_(), 51) |> ignore)

    it'("should not time out", done_ => Js.Global.setTimeout(() => done_(), 40) |> ignore)

    it_skip("should time out", ~timeout=1, () => {
      let result = ref(1)
      for x in 1 to 100000 {
        result := result.contents + x
      }
      Assert.ok(result.contents > 1)
    })
  })

  describe("Retries", () => {
    let retry_count = ref(0)
    it("should succeed", ~retries=2, () => {
      retry_count := retry_count.contents + 1
      Assert.ok(retry_count.contents == 1)
    })

    it_skip("should fail", ~retries=3, () => {
      retry_count := retry_count.contents + 1
      Assert.ok(retry_count.contents == 6)
    })
  })

  describe("Slow", () =>
    it("should be considered slow", ~slow=1, () => {
      let result = ref(1)
      for x in 1 to 100000 {
        result := result.contents + x
      }
      Assert.ok(result.contents > 1)
    })
  )
})
