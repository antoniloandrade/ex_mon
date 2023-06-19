defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotinik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  # This function is used to create a player with the specified moves.
  #
  # Args:
  #   - name: The name of the player.
  #   - move_avg: The move for average power.
  #   - move_rnd: The move for random power.
  #   - move_heal: The move for healing.
  #
  # Returns:
  #   The player with the specified moves.
  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  # This function is used to start the game with the specified player.
  #
  # Args:
  #   - player: The player to start the game with.
  #
  # Prints:
  #   The round message indicating that the game has started.
  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  # This function is used to make a move in the game.
  #
  # Args:
  #   - move: The move to be made.
  #
  # Returns:
  #   The result of the move based on the current game status.
  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  # Internal function to handle the game status and perform the appropriate actions.
  #
  # Args:
  #   - :game_over: The game status indicating that the game is over.
  #   - move: The move to be made.
  #
  # Prints:
  #   The round message indicating that the game is over.
  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  # Internal function to handle the game status and perform the appropriate actions.
  #
  # Args:
  #   - _other: Other game status.
  #   - move: The move to be made.
  #
  # Performs:
  #   - Fetches the move from the player's available moves.
  #   - Performs the move action.
  #   - Prints the round message with the updated game information.
  #   - Triggers the computer's move if it's the computer's turn.
  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  # Internal function to perform the specified move action.
  #
  # Args:
  #   - {:error, move}: The error tuple indicating an invalid move.
  #
  # Prints:
  #   The message indicating an invalid move.
  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  # Internal function to perform the specified move action.
  #
  # Args:
  #   - {:ok, move}: The valid move.
  #
  # Performs:
  #   - Calls the appropriate action based on the move type (attack or heal).
  #   - Prints the round message with the updated game information.
  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  # Internal function to trigger the computer's move.
  #
  # Args:
  #   - %{turn: :computer, status: :continue}: The game information indicating it's the computer's turn.
  #
  # Performs:
  #   - Generates a random move for the computer.
  #   - Performs the move action.
  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  # Internal function to handle the case when it's not the computer's turn or the game is over.
  #
  # Args:
  #   - _: Other game information.
  #
  # Returns:
  #   :ok
  defp computer_move(_), do: :ok
end
