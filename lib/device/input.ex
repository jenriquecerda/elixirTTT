defmodule Input do
  def get(message, device \\ :stdio) do
    IO.gets(device, message)
  end
end
