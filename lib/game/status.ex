defmodule ExMon.Game.Status do
  # This function is used to print the round message when the game is started.
  #
  # Args:
  #   - info: The game information.
  #
  # Prints:
  #   The round message indicating that the game is started.
  def print_round_message(%{status: :started} = info) do
    IO.puts("====The game is started! ====")
    IO.inspect(info)
    IO.puts("-----------------------")
  end

  # This function is used to print the round message when the game is in progress and it's the player's turn.
  #
  # Args:
  #   - info: The game information.
  #
  # Prints:
  #   The round message indicating that it's the player's turn.
  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("====It's #{player}'s turn. ====")
    IO.inspect(info)
    IO.puts("-----------------------")
  end

  # This function is used to print the round message when the game is over.
  #
  # Args:
  #   - info: The game information.
  #
  # Prints:
  #   The round message indicating that the game is over.
  def print_round_message(%{status: :game_over} = info) do
    IO.puts("===The game is over. ====")
    IO.inspect(info)
    IO.puts("-----------------------")
  end

  # This function is used to print the message for an invalid move.
  #
  # Args:
  #   - move: The invalid move.
  #
  # Prints:
  #   The message indicating the invalid move.
  def print_wrong_move_message(move) do
    IO.puts("====Invalid move: #{move} ====")
  end

  # This function is used to print the message for an attack move performed by the computer.
  #
  # Args:
  #   - :computer: The player who performed the attack.
  #   - :attack: The move type.
  #   - damage: The amount of damage dealt.
  #
  # Prints:
  #   The message indicating the attack performed by the computer and the damage dealt.
  def print_move_message(:computer, :attack, damage) do
    IO.puts("====The Player attacked the computer dealing: #{damage} damage. ====")
  end

  # This function is used to print the message for an attack move performed by the player.
  #
  # Args:
  #   - :player: The player who performed the attack.
  #   - :attack: The move type.
  #   - damage: The amount of damage dealt.
  #
  # Prints:
  #   The message indicating the attack performed by the player and the damage dealt.
  def print_move_message(:player, :attack, damage) do
    IO.puts("====The Computer attacked the player dealing: #{damage} damage. ====")
  end

  # This function is used to print the message for a healing move performed by a player.
  #
  # Args:
  #   - player: The player who performed the healing move.
  #   - :heal: The move type.
  #   - life: The amount of life points restored.
  #
  # Prints:
  #   The message indicating the healing move performed by the player and the amount of life points restored.
  def print_move_message(player, :heal, life) do
    IO.puts("====The #{player} healed itself to #{life} life points. ====")
  end
end
