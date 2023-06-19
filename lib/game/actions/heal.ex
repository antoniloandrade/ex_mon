defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @heal_power 18..25

  # This function is used to heal the life of a player.
  # It calculates the amount of life to be added based on the heal power and updates the player's life.
  #
  # Args:
  #   - player: The player whose life needs to be healed.
  #
  # Returns:
  #   The updated player with the healed life.
  def heal_life(player) do
    player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life()
    |> set_life(player)
  end

  # Calculates the total life after adding a random value within the range defined by @heal_power.
  #
  # Args:
  #   - life: The current life value.
  #
  # Returns:
  #   The updated life value after adding the random heal power.
  defp calculate_total_life(life), do: Enum.random(@heal_power) + life

  # Sets the life to a maximum of 100 if the calculated life exceeds it.
  #
  # Args:
  #   - life: The calculated life value.
  #   - player: The player whose life needs to be set.
  #
  # Returns:
  #   The updated player with the life set to the maximum value.
  defp set_life(life, player) when life > 100, do: update_player_life(player, 100)
  defp set_life(life, player), do: update_player_life(player, life)

  # Updates the player's life with the new life value.
  #
  # Args:
  #   - player: The player whose life needs to be updated.
  #   - life: The updated life value.
  #
  # Returns:
  #   The player with the updated life value.
  defp update_player_life(player, life) do
    player
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(player, life)
  end

  # Updates the game state after the healing move by updating the player in the game information.
  # It also prints the move message using the Status module.
  #
  # Args:
  #   - player_data: The player data to be updated.
  #   - player: The player whose life has been healed.
  #   - life: The amount of life healed.
  #
  # Returns:
  #   The updated game information.
  defp update_game(player_data, player, life) do
    Game.info()
    |> Map.put(player, player_data)
    |> Game.update()

    Status.print_move_message(player, :heal, life)
  end
end
