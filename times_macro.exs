defmodule Times do
  defmacro times_n(n) do
    func_name = String.to_atom("times_#{n}")
    quote do
      def unquote(func_name)(args) do
        args * unquote(n)
      end
    end
  end
end

defmodule Test do
  require Times

  # these calls define methods really. fucked up
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts Test.times_3(4)
IO.puts Test.times_4(5)