defmodule Day3 do
  def part1 do
    "day03.txt"
    |> File.read!()
    |> String.trim()
    |> to_charlist()
    |> Enum.reduce({{0,0}, %{{0,0} => 1}}, &reducer/2)
    |> elem(1)
    |> Enum.count()
  end

  def part2 do
    pairs =
      "day03.txt"
      |> File.read!()
      |> String.trim()
      |> to_charlist()
      |> Enum.chunk_every(2)

    {_, santa_drops} =
      pairs
      |> Enum.map(&(Enum.at(&1,0)))
      |> Enum.reduce({{0,0}, %{{0,0} => 2}}, &reducer/2)

    {_, robo_drops} = 
      pairs
      |> Enum.map(&(Enum.at(&1,1)))
      |> Enum.reduce({{0,0}, santa_drops}, &reducer/2)

    Enum.count(robo_drops)
  end
  
  def reducer(direction, {{x, y}, houses}) do
    case direction do
      ?^ -> {{x, y+1}, Map.update(houses, {x, y+1}, 1, &(&1 + 1))}
      ?v -> {{x, y-1}, Map.update(houses, {x, y-1}, 1, &(&1 + 1))}
      ?< -> {{x-1, y}, Map.update(houses, {x-1, y}, 1, &(&1 + 1))}
      ?> -> {{x+1, y}, Map.update(houses, {x+1, y}, 1, &(&1 + 1))}
    end
  end



end