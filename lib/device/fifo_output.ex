defmodule FifoOutput do
  def print(path) do
    fn message ->
      {_, file} = File.open(path, [:write])
      IO.puts(file, message)
    end
  end
end
