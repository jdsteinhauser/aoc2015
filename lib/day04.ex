defmodule Day4 do
  @input "bgvyzdsv"

  def part1 do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(fn x -> :crypto.hash(:md5, @input <> Integer.to_string(x)) end)
    |> Stream.map(&Base.encode16/1)
    |> Stream.with_index()
    |> Stream.drop_while(&(not String.starts_with?(elem(&1,0), "00000")))
    |> Enum.at(0)
  end

  def part2 do
    Stream.iterate(0, &(&1 + 1))
    |> Stream.map(fn x -> :crypto.hash(:md5, @input <> Integer.to_string(x)) end)
    |> Stream.map(&Base.encode16/1)
    |> Stream.with_index()
    |> Stream.drop_while(&(not String.starts_with?(elem(&1,0), "000000")))
    |> Enum.at(0)
  end
end