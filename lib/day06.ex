defmodule Day6 do

  def part1 do
    grid = for x <- 0..999, y <- 0..999, into: %{}, do: {{x,y}, false}
    data()
    |> Enum.map(&commands/1)
    |> Enum.reduce(grid, fn {cmd, box}, acc -> execute(cmd, box, acc) end)
    |> Enum.count(fn {_, x} -> x end)
  end

  def part2 do
    grid = for x <- 0..999, y <- 0..999, into: %{}, do: {{x,y}, 0}
    data()
    |> Enum.map(&commands2/1)
    |> Enum.reduce(grid, fn {cmd, box}, acc -> execute(cmd, box, acc) end)
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.sum()
  end

  def data, do: File.stream!("day06.txt")

  def commands("turn on " <> box), do: {fn _x -> true end, parse_box(box)}
  def commands("turn off" <> box), do: {fn _x -> false end, parse_box(box)}
  def commands("toggle" <> box), do: {fn x -> !x end, parse_box(box)}

  def commands2("turn on " <> box), do: {fn x -> x + 1 end, parse_box(box)}
  def commands2("turn off" <> box), do: {fn x -> max(0, x - 1) end, parse_box(box)}
  def commands2("toggle" <> box), do: {fn x -> x + 2 end, parse_box(box)}

  def parse_box(line) do
    [left, top, _, right, bottom] = String.split(line, [" ", ",", "\n"], trim: true)
    { 
       String.to_integer(top),
       String.to_integer(left),
       String.to_integer(bottom),
       String.to_integer(right)
    }
  end

  def execute(command, {top, left, bottom, right}, grid) do
    for x <- left..right, y <- top..bottom
    do
      {x,y}
    end
    |> Enum.reduce(grid, fn coord, acc -> Map.update!(acc, coord, command) end)
  end
end