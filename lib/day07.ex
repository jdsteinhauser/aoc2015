defmodule Day7 do
  use Bitwise

  def part1 do
    data()
    |> IO.inspect()
    |> get_value(:a)
  end

  def data do
    "day07.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line -> String.split(line, [" ", "->"], trim: true) end)
    |> Enum.map(&build_gate/1)
    |> Map.new()
  end

  def get_value(map, value) do
    IO.puts value
    Map.get(map, value).(map)
  end

  def build_gate([sig, name]) do
    IO.puts "#{ String.to_atom(name)}: #{sig}"
    { String.to_atom(name), (fn _map -> parse_signal(sig) end)}
  end

  def build_gate([sig1, "AND", sig2, name]) do
    { String.to_atom(name), (fn map -> get_value(map, sig1) &&& get_value(map, sig2) end)}
  end

  def build_gate([sig1, "OR", sig2, name]) do
    { String.to_atom(name), fn map -> get_value(map, sig1) ||| get_value(map, sig2) end}
  end

  def build_gate(["NOT", sig, name]) do
    { String.to_atom(name), fn map -> ~~~ get_value(map, sig) end}
  end

  def build_gate([sig1, "LSHIFT", sig2, name]) do
    { String.to_atom(name), fn map -> (get_value(map, sig1) <<< get_value(map, sig2) &&& 65535) end}
  end

  def build_gate([sig1, "RSHIFT", sig2, name]) do
    { String.to_atom(name), fn map -> (get_value(map, sig1) >>> get_value(map, sig2) &&& 65535) end}
  end

  def parse_signal(signal) do
    if Integer.parse(signal) != :error
    do
      fn _ -> String.to_integer(signal) end
    else
      fn map -> get_value(map, String.to_atom(signal)) end
    end
  end

end