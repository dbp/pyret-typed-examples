#lang pyret

fun project-foo<A>(r :: {foo : A}) -> A:
  r.foo
end

# should work - argument inferred as {a : Number, b : Number, foo : Number},
# which is width and subtype of {foo : A} when instantiated with A := Number
project-foo({a: 10, b: 20, foo: 30})

# should fail to check
project-foo({a: 10})

# can we infer the typed version above? We should be able to see that
# r has to have a foo field (ie, r starts as (U)+{}, and any field access
# adds to the record, any type test adds to the union)
fun project-untyped(r):
  r.foo
end

# in general, we won't be able to figure out anything, aside from _maybe_
# r :: {_ : A}, and the return type is A.
fun project-untyped2(r):
  r.["foo"]
end

# should fail in project-untyped2 when trying to look up
project-untyped2({a : 10})
