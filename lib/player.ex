defmodule ExMon.Player do
  @required_keys [:life, :moves, :name]
  @max_life 100

  @enforce_keys @required_keys

  defstruct @required_keys

  # This function is used to create a player with the specified parameters.
  #
  # Args:
  #   - name: The name of the player.
  #   - move_rnd: The random move for the player.
  #   - move_avg: The average move for the player.
  #   - move_heal: The healing move for the player.
  #
  # Returns:
  #   The player struct with the specified attributes.
  def build(name, move_rnd, move_avg, move_heal) do
    %ExMon.Player{
      life: @max_life,
      moves: %{
        move_avg: move_avg,
        move_heal: move_heal,
        move_rnd: move_rnd
      },
      name: name
    }
  end
end
