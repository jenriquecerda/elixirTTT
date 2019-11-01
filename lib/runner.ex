defmodule Runner do
  def main(_argv) do
    current_path = "/home/quique/Dynamic/Elixir/tictactoe"

    human_symbol = "O"
    cpu_symol = "X"

    board = Board.create(9)

    human_input = FifoInput.get(String.to_charlist(current_path <> "/in"))

    cpu_input = fn board ->
      MiniMax.options(&WinningRules.winner/1, board, [cpu_symol, human_symbol])
    end

    output = FifoOutput.print(String.to_charlist(current_path <> "/out"))

    player_one = fn board -> Human.mark(board, human_symbol, human_input) end
    player_two = fn board -> CPU.mark(board, cpu_symol, &Chooser.choose/1, cpu_input) end
    players = [player_one, player_two]

    board = TicTacToe.play_game(board, players, WinningRules, output)
  end
end
