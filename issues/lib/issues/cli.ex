defmodule Issues.CLI do

  import Issues.TableFormatter, only: [pretty_print: 2]
  
  @default_count 4

  @moduledoc """
  Handle the command crap
  """

  def main(argv) do
    argv
      |> parse_args
      |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} ->
        :help
      {_, [user, project, count], _} ->
        {user, project, String.to_integer(count)}
      {_, [user, project], _} ->
        {user, project, @default_count}
      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts "usage: issues <user> <project> [ count ]"
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
      |> decode_response
      |> sort_asc
      |> Enum.take(count) 
      |> pretty_print(["number", "created_at", "title"])
  end

  def sort_asc(list) do
    sorter = fn(x, y) -> 
      Map.get(x, "created_at") <= Map.get(y, "created_at")
    end

    Enum.sort(list, sorter)
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetchig from Github: #{message}"
    System.halt(2)
  end
end