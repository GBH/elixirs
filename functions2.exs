handle_open = fn
  {:ok, file} -> "data: #{IO.read(file, :all)}"
  {:error, message} -> "Shit's fucked: #{:file.format_error(message)}"
end

IO.puts handle_open.(File.open("/etc/passwd"))
IO.puts handle_open.(File.open("/shit"))