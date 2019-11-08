defmodule FifoOutput do
  def print(path) do
    fn message ->
      {_, file} = File.open(path, [:write])

      if is_map(message) do
        Map.keys(message)
        |> Enum.map(fn key ->
          if !is_nil(Map.get(message, key)) do
            "#{key}-#{message[key]};"
          end
        end)
        |> Enum.filter(&(!is_nil(&1)))
        |> List.to_string()
        |> (fn x -> IO.puts(file, x) end).()
      else
        IO.puts(file, message)
      end
    end
  end
end
