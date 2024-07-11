/// Raw fixed-point combinator.
/// Not intended to be used standalone
pub fn rec(f) {
  f(fn() { rec(f) })
}

/// Fixed-point combinator.
/// Allows anonymous functions to run recursively
/// ```gleam
/// let factorial = recursive.func(fn (it, f) {
///   case it {
///     0 -> 1
///     1 -> 1
///     _ -> it * f(it - 1)
///   }
/// })
/// io.debug(factorial(10))
/// ```
pub fn func(cb) {
  rec(fn(f) { fn(a) { cb(a, cb(_, f())) } })
}

/// Two argument Fixed-point combinator.
/// Allows anonymous functions to run recursively
/// ```gleam
/// let factorial = recursive.func2(fn (it, res, f) {
///   case it {
///     0 -> res
///     1 -> res
///     _ -> f(it - 1, res * it)
///   }
/// })
/// io.debug(factorial(10, 1))
/// ```
pub fn func2(cb) {
  rec(fn(f) { fn(a, b) { cb(a, b, fn(a, b) { cb(a, b, f()) }) } })
}

/// Three argument Fixed-point combinator.
/// Allows anonymous functions to run recursively
/// ```gleam
/// let fibonacci = recursive.func3(fn (it, curr, prev, f) {
///    case it {
///      0 -> curr
///      _ -> f(it - 1, curr + prev, curr)
///    }
/// })
/// io.debug(fibonacci(9, 1, 0))
/// ```
pub fn func3(cb) {
  rec(fn(f) { fn(a, b, c) { cb(a, b, c, fn(a, b, c) { cb(a, b, c, f()) }) } })
}

/// Four argument Fixed-point combinator.
/// Allows anonymous functions to run recursively
pub fn func4(cb) {
  rec(fn(f) {
    fn(a, b, c, d) { cb(a, b, c, d, fn(a, b, c, d) { cb(a, b, c, d, f()) }) }
  })
}

/// Five argument Fixed-point combinator.
/// Allows anonymous functions to run recursively
pub fn func5(cb) {
  rec(fn(f) {
    fn(a, b, c, d, e) {
      cb(a, b, c, d, e, fn(a, b, c, d, e) { cb(a, b, c, d, e, f()) })
    }
  })
}

/// Fixed-point combinator.
/// Allows any block to run recursively
/// ```gleam
/// // Factorial 
/// io.debug({
///   use it, f <- recursive.block(10)
///   case it {
///     0 -> 1
///     1 -> 1
///     _ -> it * f(it - 1)
///   }
/// })
/// ```
pub fn block(initial, cb) {
  func(cb)(initial)
}

/// Two argument Fixed-point combinator.
/// Allows any block to run recursively
/// ```gleam
/// // Tail recursive factorial 
/// io.debug({
///   use it, res, f <- recursive.block2(10, 1)
///   case it {
///     0 -> res
///     1 -> res
///     _ -> f(it - 1, res * it)
///   }
/// })
/// ```
pub fn block2(a, b, cb) {
  func2(cb)(a, b)
}

/// Three argument Fixed-point combinator.
/// Allows any block to run recursively
/// ```gleam
/// // Fibonacci 
/// io.debug({
///   use it, curr, prev, f <- recursive.block3(9, 1, 0)
///   case it {
///    0 -> curr
///    _ -> f(it - 1, curr + prev, curr)
///   }
/// })
/// ```
pub fn block3(a, b, c, cb) {
  func3(cb)(a, b, c)
}

/// Four argument Fixed-point combinator.
/// Allows any block to run recursively
pub fn block4(a, b, c, d, cb) {
  func4(cb)(a, b, c, d)
}

/// Five argument Fixed-point combinator.
/// Allows any block to run recursively
pub fn block5(a, b, c, d, e, cb) {
  func5(cb)(a, b, c, d, e)
}
