defmodule ExMon.Game.Actions.Attack do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_avg_power 18..25
  @move_rnd_power 10..35

  # This function is used to attack the opponent with a specific move.
  # It calculates the damage power based on the move type and updates the opponent's life.
  #
  # Args:
  #   - opponent: The opponent player to be attacked.
  #   - move: The move type (:move_avg or :move_rnd) to be used for the attack.
  #
  # Returns:
  #   The updated opponent after the attack.
  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(damage)
    |> update_opponent_life(opponent, damage)
  end

  # Calculates the power of the move when it is of type :move_avg.
  #
  # Args:
  #   - :move_avg: The move type.
  #
  # Returns:
  #   The calculated power within the range defined by @move_avg_power.
  defp calculate_power(:move_avg), do: Enum.random(@move_avg_power)

  # Calculates the power of the move when it is of type :move_rnd.
  #
  # Args:
  #   - :move_rnd: The move type.
  #
  # Returns:
  #   The calculated power within the range defined by @move_rnd_power.
  defp calculate_power(:move_rnd), do: Enum.random(@move_rnd_power)

  # Calculates the total life after deducting the damage from the current life.
  #
  # Args:
  #   - life: The current life value.
  #   - damage: The damage to be deducted from the life.
  #
  # Returns:
  #   The updated life value after deducting the damage.
  defp calculate_total_life(life, damage) when life - damage < 0, do: 0
  defp calculate_total_life(life, damage), do: life - damage

  # Updates the opponent's life with the new life value.
  #
  # Args:
  #   - life: The updated life value.
  #   - opponent: The opponent player.
  #   - damage: The damage inflicted by the attack.
  #
  # Returns:
  #   The opponent with the updated life value.
  defp update_opponent_life(life, opponent, damage) do
    opponent
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(opponent, damage)
  end

  # Updates the game state after the attack by updating the opponent in the game information.
  # It also prints the move message using the Status module.
  #
  # Args:
  #   - player: The player making the attack.
  #   - opponent: The opponent player.
  #   - damage: The damage inflicted by the attack.
  #
  # Returns:
  #   The updated game information.
  defp update_game(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
