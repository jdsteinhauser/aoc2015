defmodule Day2 do
  def part1 do
    data()
    |> Enum.map(&calc_paper/1)
    |> Enum.sum()
  end

  def part2 do
    data()
    |> Enum.map(&calc_ribbon/1)
    |> Enum.sum()
  end

  def data do
    "day02.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn x -> String.split(x, "x") |> Enum.map(&String.to_integer/1) end)
  end

  def calc_paper(dims) do
    sides = 
      dims
      |> Enum.zip(Stream.drop(Stream.cycle(dims), 1))
      |> Enum.map(fn {x,y} -> x * y end)

    Enum.min(sides) + 2 * Enum.sum(sides)
  end

  def calc_ribbon(dims) do
    [ _hd | smaller_dims] = Enum.sort(dims, &(&1 >= &2))
    Enum.reduce(dims, &Kernel.*/2) + 2 * Enum.sum(smaller_dims)
  end
end