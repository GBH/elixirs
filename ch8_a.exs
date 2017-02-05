defmodule Canvas do

  @defaults [fg: "black", bg: "white", font: "Times"]

  def draw_text(text, options \\ []) do
    options = Keyword.merge(@defaults, options)

    IO.puts "Drawing text: #{text}"
    IO.puts "foreground: #{options[:fg]}"
    IO.puts "background: #{Keyword.get(options, :bg)}"
    IO.puts "style: #{inspect Keyword.get_values(options, :style)}"
    IO.puts "style: #{Keyword.get(options, :style)}"
  end

end


Canvas.draw_text("test", style: "hot", style: "cold")