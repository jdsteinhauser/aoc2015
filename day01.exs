data = File.read!("day01.txt") |> to_charlist()

ans1 = Enum.count(data, &(&1 == ?()) - Enum.count(data, &(&1 == ?)))
ans2 = Enum.reduce_while(data, {0,0}, fn x, {sum, count} -> if sum < 0, do: {:halt, count}, else: {:cont, {sum + (if x == ?(, do: 1, else: -1) , count + 1}} end)

IO.puts "Answer 1: #{ans1}"
IO.puts "Answer 2: #{ans2}"