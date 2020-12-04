data = 
  File.read!("day03.txt") |>
  String.trim() |>
  to_charlist()

reducer = fn direction, {{x, y}, houses} ->
  case direction do
    ?^ -> {{x, y+1}, Map.update(houses, {x, y+1}, 1, &(&1 + 1))}
    ?v -> {{x, y-1}, Map.update(houses, {x, y-1}, 1, &(&1 + 1))}
    ?< -> {{x-1, y}, Map.update(houses, {x-1, y}, 1, &(&1 + 1))}
    ?> -> {{x+1, y}, Map.update(houses, {x+1, y}, 1, &(&1 + 1))}
  end
end

{_, dropoffs} = Enum.reduce(data, {{0,0}, %{{0,0} => 1}}, &(reducer.(&1,&2)))

ans1 = Enum.count(dropoffs)

pairs = Enum.chunk_every(data, 2)
{_, santa_drops} = Enum.reduce(Enum.map(pairs, &(Enum.at(&1,0))), {{0,0}, %{{0,0} => 2}}, &(reducer.(&1,&2)))
{_, robo_drops} = Enum.reduce(Enum.map(pairs, &(Enum.at(&1,1))), {{0,0}, santa_drops}, &(reducer.(&1,&2)))

ans2 = Enum.count(robo_drops)

IO.puts "Answer 1: #{ans1}"
IO.puts "Answer 2: #{ans2}"