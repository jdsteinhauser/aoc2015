defmodule Day1 do
  def part1 do
    data = 
      "day01.txt"
      |> File.read!()
      |> to_charlist()

    Enum.count(data, &(&1 == ?()) - Enum.count(data, &(&1 == ?)))
  end

  def part2 do
    data = 
      "day01.txt"
      |> File.read!()
      |> to_charlist()
      |> Enum.reduce_while(
              {0,0},
              fn x, {sum, count} ->
                if sum < 0
                do 
                  {:halt, count}
                else
                  {:cont, {sum + (if x == ?(, do: 1, else: -1), count + 1}}
                end
              end)
  end
end