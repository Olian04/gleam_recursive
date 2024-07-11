import gleeunit
import gleeunit/should
import recursive

pub fn main() {
  gleeunit.main()
}

fn fac(it, f) {
  case it {
    0 -> 1
    1 -> 1
    _ -> it * f(it - 1)
  }
}

fn memo_fac(it, res, f) {
  case it {
    0 -> res
    1 -> res
    _ -> f(it - 1, res * it)
  }
}

fn fib(it, curr, prev, f) {
  case it {
    0 -> curr
    _ -> f(it - 1, curr + prev, curr)
  }
}

fn sum(a, b, c, d, f) {
  case a, b, c, d {
    0, 0, 0, 0 -> 0
    0, 0, 0, v -> 1 + f(0, 0, 0, v - 1)
    0, 0, v, _ -> 1 + f(0, 0, v - 1, d)
    0, v, _, _ -> 1 + f(0, v - 1, c, d)
    v, _, _, _ -> 1 + f(v - 1, b, c, d)
  }
}

fn memo_sum(a, b, c, d, res, f) {
  case a, b, c, d {
    0, 0, 0, 0 -> res
    0, 0, 0, v -> f(0, 0, 0, v - 1, res + 1)
    0, 0, v, _ -> f(0, 0, v - 1, d, res + 1)
    0, v, _, _ -> f(0, v - 1, c, d, res + 1)
    v, _, _, _ -> f(v - 1, b, c, d, res + 1)
  }
}

pub fn fix_test() {
  recursive.fix(fac)(10)
  |> should.equal(3_628_800)
}

pub fn fix2_test() {
  recursive.fix2(memo_fac)(10, 1)
  |> should.equal(3_628_800)
}

pub fn fix3_test() {
  recursive.fix3(fib)(9, 1, 0)
  |> should.equal(55)
}

pub fn fix4_test() {
  recursive.fix4(sum)(1, 2, 3, 4)
  |> should.equal(10)
}

pub fn fix5_test() {
  recursive.fix5(memo_sum)(1, 2, 3, 4, 0)
  |> should.equal(10)
}

pub fn use_fix_test() {
  {
    use it, f <- recursive.use_fix(10)
    fac(it, f)
  }
  |> should.equal(3_628_800)
}

pub fn use_fix2_test() {
  {
    use it, res, f <- recursive.use_fix2(10, 1)
    memo_fac(it, res, f)
  }
  |> should.equal(3_628_800)
}

pub fn use_fix3_test() {
  {
    use it, curr, prev, f <- recursive.use_fix3(9, 1, 0)
    fib(it, curr, prev, f)
  }
  |> should.equal(55)
}

pub fn use_fix4_test() {
  {
    use a, b, c, d, f <- recursive.use_fix4(1, 2, 3, 4)
    sum(a, b, c, d, f)
  }
  |> should.equal(10)
}

pub fn use_fix5_test() {
  {
    use a, b, c, d, res, f <- recursive.use_fix5(1, 2, 3, 4, 0)
    memo_sum(a, b, c, d, res, f)
  }
  |> should.equal(10)
}
