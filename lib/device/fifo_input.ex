defmodule FifoInput do
  def get(port) do
    fn ->
      in_fifo = Port.open(port, [:binary, :line])

      receive do
        {in_fifo, {:data, {:eol, msg}}} -> msg
        true -> get(port)
      end
      |> String.trim()
      |> String.to_integer()
    end
  end
end
