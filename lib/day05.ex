defmodule Day5 do

  def part1 do
    "day05.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.count(&is_nice?/1)
  end

  def part2 do
    "day05.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.count(&is_nice2?/1)
  end

  def is_nice?(str) do
    chars = to_charlist str
    three_vowels? = Enum.count(chars, fn x -> Enum.any?('aeiou', &(&1 == x)) end) >= 3
    double_letter? = 
      chars
      |> Enum.chunk_by(&(&1))
      |> Enum.map(&Enum.count/1)
      |> Enum.any?(&(&1 >= 2))
    all_allowed? = 
      ["ab", "cd", "pq", "xy"]
      |> Enum.all?(&(not String.contains?(str, &1)))

    three_vowels? and double_letter? and all_allowed?
  end

  def is_nice2?(str) do
    Regex.match?(~r/\w*(\w\w)\w*\1\w*/, str) and Regex.match?(~r/\w*(\w)\w\1\w*/, str)
  end
end