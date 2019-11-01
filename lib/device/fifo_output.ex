defmodule FifoOutput do
  def print(port) do
    opened_port = Port.open(port, [:binary, :eof])
    fn message ->
      send(opened_port, {self, {:command, message}})
    end
  end
end
