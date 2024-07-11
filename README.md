[![Package Version](https://img.shields.io/hexpm/v/recursive)](https://hex.pm/packages/recursive)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/recursive/)

# recursive

This library provides user/developer friendly Fixed-point combinator functions.

```sh
gleam add recursive
```

## Recursive block

```gleam
import gleam/io
import recursive

pub fn main() {
   // Factorial
   io.debug({
    use it, f <- recursive.block(10)
    case it {
      0 -> 1
      _ -> it * f(it - 1)
    }
   })

   // Tail recursive factorial
   io.debug({
    use it, res, f <- recursive.block2(10, 1)
    case it {
      0 -> res
      _ -> f(it - 1, res * it)
    }
   })

   // Tail recursive fibonacci
   io.debug({
    use it, curr, prev, f <- recursive.block3(9, 1, 0)
    case it {
      0 -> curr
      _ -> f(it - 1, curr + prev, curr)
    }
   })
}
```

## Recursive anonymous function

```gleam
import gleam/io
import recursive

pub fn main() {
   // Factorial
   let fac = recursive.func(fn (it, f) {
      case it {
        0 -> 1
        _ -> it * f(it - 1)
      }
   })
   io.debug(fac(10))

   // Tail recursive factorial
   let memo_fac = recursive.func(fn (it, res, f) {
      case it {
        0 -> res
        _ -> f(it - 1, res * it)
      }
   })
   io.debug(fac(10, 1))

   // Tail recursive fibonacci
   let fib = recursive.func(fn (it, curr, prev, f) {
      case it {
        0 -> curr
        _ -> f(it - 1, curr + prev, curr)
      }
   })
   io.debug(fac(9, 1, 0))
}
```

## Development

```sh
gleam test
```

---
Further documentation can be found at <https://hexdocs.pm/recursive>.
