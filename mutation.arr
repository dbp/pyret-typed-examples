#lang pyret

# should this typecheck? no, but where should it fail:
# 1. at assignment of b: b is inferred as String, assignment of a Number fails
# 2. on return: once b is assigned to 10, it's type becomes (String U Number),
#    which is not a subtype of String
fun foo(a :: String) -> String:
  var b: a
  b := 10
  b
end