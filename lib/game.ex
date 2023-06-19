defmodule ExMon.Game do
  alias ExMon.Player
  use Agent

  # This function is used to start the game by initializing the game state.
  #
  # Args:
  #   - computer: The computer player.
  #   - player: The human player.
  #
  # Returns:
  #   The game state agent.
  def start(computer, player) do
    initial_value = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  # This function is used to retrieve the current game information.
  #
  # Returns:
  #   The current game information.
  def info do
    Agent.get(__MODULE__, & &1)
  end

  # This function is used to update the game state.
  #
  # Args:
  #   - state: The new game state.
  #
  # Performs:
  #   - Updates the game status and turn based on the new state.
  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_status(state) end)
  end

  # This function returns the player information from the current game state.
  #
  # Returns:
  #   The player information.
  def player, do: Map.get(info(), :player)

  # This function returns the current turn from the game state.
  #
  # Returns:
  #   The current turn.
  def turn, do: Map.get(info(), :turn)

  # This function fetches the specified player information from the current game state.
  #
  # Args:
  #   - player: The player key (:player or :computer).
  #
  # Returns:
  #   The player information.
  def fetch_player(player), do: Map.get(info(), player)

  # Internal function to update the game status and turn based on the current state.
  #
  # Args:
  #   - %{player: %Player{life: player_life}, computer: %Player{life: computer_life}} = state:
  #     The current game state.
  #
  # Performs:
  #   - Checks if either player's life is zero and updates the game status accordingly.
  defp update_game_status(
         %{player: %Player{life: player_life}, computer: %Player{life: computer_life}} = state
       )
       when player_life == 0 or computer_life == 0,
       do: Map.put(state, :status, :game_over)

  # Internal function to update the game status and turn based on the current state.
  #
  # Args:
  #   - state: The current game state.
  #
  # Returns:
  #   The updated game state with the status set to :continue and the turn updated.
  defp update_game_status(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn()
  end

  # Internal function to update the turn based on the current state.
  #
  # Args:
  #   - %{turn: :player} = state: The current game state.
  #
  # Returns:
  #   The updated game state with the turn set to :computer.
  defp update_turn(%{turn: :player} = state), do: Map.put(state, :turn, :computer)

  # Internal function to update the turn based on the current state.
  #
  # Args:
  #   - %{turn: :computer} = state: The current game state.
  #
  # Returns:
  #   The updated game state with the turn set to :player.
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :player)
end
