is_nice? = fn str ->
  chars = to_charlist str
  three_vowels? = Enum.count(chars, fn x -> Enum.any?('aeiou', &(&1 == x)) end) >= 3
  double_letter? = chars |> Enum.chunk_by(&(&1)) |> Enum.map(&Enum.count/1) |> Enum.any?(&(&1 >= 2))
  all_allowed? = ["ab", "cd", "pq", "xy"] |> Enum.all?(&(not String.contains?(str, &1)))

  three_vowels? and double_letter? and all_allowed?
end

is_nice2? = fn str ->
  Regex.match?(~r/\w*(\w\w)\w*\1\w*/, str) &&
  Regex.match?(~r/\w*(\w)\w\1\w*/, str)
end

data = 
  File.stream!("day05.txt") |>
  Enum.map(&String.trim/1)

ans1 = Enum.count(data, &(is_nice?.(&1)))

IO.puts "Answer 1: #{ans1}"

ans2 = Enum.count(data, &(is_nice2?.(&1)))

IO.puts "Answer 2: #{ans2}"