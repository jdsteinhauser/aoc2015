calc_paper = fn dims ->
  sides = Enum.zip(dims, Stream.drop(Stream.cycle(dims) , 1)) |> Enum.map(fn {x,y} -> x * y end)
  Enum.min(sides) + 2 * Enum.sum(sides)
end

calc_ribbon = fn dims ->
    [ _hd | smaller_dims] = Enum.sort(dims, &(&1 >= &2))
    Enum.reduce(dims, &Kernel.*/2) + 2 * Enum.sum(smaller_dims)
end

data = 
  File.stream!("day02.txt") |>
  Enum.map(&String.trim/1) |>
  Enum.map(fn x -> String.split(x, "x") |> Enum.map(&String.to_integer/1) end)

ans1 =
  data |>
  Enum.map(&(calc_paper.(&1))) |>
  Enum.sum()

ans2 =
  data |>
  Enum.map(&(calc_ribbon.(&1))) |>
  Enum.sum()

IO.puts "Answer 1: #{ans1}"
IO.puts "Answer 2: #{ans2}"
