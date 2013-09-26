#lang pyret

fun map<A,B>(fn :: (A -> B), l :: List<A>) -> List<B>:
  cases(List) l:
    | empty => empty
    | link(f,r) => link(fn(f),map(fn, r))
  end
end

# should work
map(fun x: x+1 end, [1,2,3])

# should fail - error is that fn is inferred to Number -> Number, and
# l is inferred as List<Number U String>, and Number U String is not a
# subtype of Number
map(fun x: x+1 end, [1,2,'a'])

fun generate-list<A>(n :: Number, a :: A) -> List<A>:
  if n == 0:
    empty
  else:
    link(a, generate-list(n-1,a))
  end
end

# should work: generate-list is instantiated with A := Number, which means it's
# return type is List<Number>, and fn is inferred as ∀A.A->A, which should be
# unified with Number.
map(fun x: x end, generate-list(10, 1))

fun untyped-generate(n :: Number, a) -> List:
  if n == 0:
    empty
  else:
    link(a, untyped-generate(n-1,a))
  end
end

# should infer fn to Number -> Number, which means that untyped-generate must return
# a List<Number>. checking that through a contract... not sure (the constructed type problem).
map(fun x: x+1 end, untyped-generate(10, 0))
