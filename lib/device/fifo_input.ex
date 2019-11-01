defmodule FifoInput do
  def get(port) do
    fn ->
      in_fifo = Port.open(port, [:binary, :eof])

      receive do
        {in_fifo, {:data, msg}} -> msg
        true ->
      end
      |> String.trim()
      |> String.to_integer()
    end
  end
end
