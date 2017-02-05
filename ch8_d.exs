m = %{ a: 1, b: 2, c: 3 }
IO.inspect(m)

m1 = %{ m | b: "foo"}
IO.inspect(m1)