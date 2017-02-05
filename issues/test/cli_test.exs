defmodule CliTest do
	use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_asc: 1]

  test "parse_args with -h or --help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "parse_args with 3 values" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "parse_args with 2 values" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort_asc" do
    list = [%{"created_at" => "a"}, %{"created_at" => "c"}, %{"created_at" => "b"}]
    items = for item <- sort_asc(list), do: Map.get(item, "created_at")
    assert items == ~w(a b c)
  end


end