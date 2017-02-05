defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_)     -> "Who are you?"
    end
  end
end

greeter = Greeter.for("oleg", "wazzap")

IO.puts greeter.("oleg")
IO.puts greeter.("dude")