# recursive

[![Package Version](https://img.shields.io/hexpm/v/recursive)](https://hex.pm/packages/recursive)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/recursive/)

```sh
gleam add recursive
```

```gleam
import gleam/io
import recursive

pub fn main() {
   // Factorial
   io.debug({
    use it, f <- recursive.use_fix(10)
    case it {
      0 -> 1
      _ -> it * f(it - 1)
    }
   })
   let fac = recursive.fix(fn (it, f) {
      case it {
        0 -> 1
        _ -> it * f(it - 1)
      }
   })

   // Tail recursive factorial
   io.debug({
    use it, res, f <- recursive.use_fix2(10, 1)
    case it {
      0 -> res
      _ -> f(it - 1, res * it)
    }
   })
   let memo_fac = recursive.fix2(fn (it, res, f) {
      case it {
        0 -> res
        _ -> f(it - 1, res * it)
      }
   })

   // Tail recursive fibonacci
   io.debug({
    use it, curr, prev, f <- recursive.use_fix3(9, 1, 0)
    case it {
      0 -> curr
      _ -> f(it - 1, curr + prev, curr)
    }
   })
   let fib = recursive.fix3(fn (it, curr, prev, f) {
      case it {
        0 -> curr
        _ -> f(it - 1, curr + prev, curr)
      }
   })
}
```

Further documentation can be found at <https://hexdocs.pm/recursive>.

## Development

```sh
gleam test
```
