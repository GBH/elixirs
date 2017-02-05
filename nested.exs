defmodule Customer do
  defstruct name: "", company: ""
end

defmodule Bugreport do
  defstruct owner: %Customer{}, details: "", severity: 1
end