defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  # This function is used to perform an attack move.
  # It determines the current turn and calls the appropriate attack function based on the turn.
  #
  # Args:
  #   - move: The move type to be used for the attack.
  #
  # Returns:
  #   The result of the attack operation.
  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  # This function is used to perform a healing move.
  # It determines the current turn and calls the appropriate heal function based on the turn.
  #
  # Returns:
  #   The result of the healing operation.
  def heal() do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end

  # This function is used to fetch a specific move from the player's available moves.
  #
  # Args:
  #   - move: The move to be fetched.
  #
  # Returns:
  #   The key of the move if found, otherwise an error tuple.
  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  # Internal function to find the key of a move in the available moves list.
  #
  # Args:
  #   - moves: The list of available moves.
  #   - move: The move to be found.
  #
  # Returns:
  #   The key of the move if found, otherwise an error tuple.
  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value === move, do: {:ok, key}
    end)
  end
end
