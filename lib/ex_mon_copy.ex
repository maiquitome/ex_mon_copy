defmodule ExMonCopy do
  @moduledoc """
  Documentation for `ExMonCopy`.
  """
  @computer_name "Charizard"

  @doc """
  Create Player.

  ## Examples

      iex> ExMonCopy.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
      %ExMon.Player{
        life_points: 100,
        moves: %{
          average_attack: :tail_whip,
          healing_power: :heal,
          random_attack: :thunderbolt
        },
        name: "Pikachu"
      }

  """
  def create_player(name, random_attack, average_attack, healing_power) do
    ExMonCopy.Player.build(name, random_attack, average_attack, healing_power)
  end

  @doc """
  Starts the game.

  ## Examples

      iex> human_pokemon = ExMonCopy.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
      %ExMonCopy.Player{
        life_points: 100,
        moves: %{
          average_attack: :tail_whip,
          healing_power: :heal,
          random_attack: :thunderbolt
        },
        name: "Pikachu"
      }

      iex> ExMonCopy.start_game(human_pokemon)
      {:ok, #PID<0.450.0>}

  """
  def start_game(human) do
    @computer_name
    |> ExMonCopy.create_player(:fire_spin, :claw_slash, :heal)
    |> ExMonCopy.Game.start(human)

    ExMonCopy.Game.Status.print_round_message()
  end

  @doc """
  Making move.

  ## Examples



  """
  def make_move(move) do
    move
    |> ExMonCopy.Game.Actions.fetch_move()
    |> do_move()
  end

  # iex> ExMonCopy.Game.Actions.fetch_move(:test)
  # {:error, :test}
  defp do_move({:error, move}), do: ExMonCopy.Game.Status.print_wrong_move_message(move)

  # iex> ExMonCopy.Game.Actions.fetch_move(:thunderbolt)
  # {:ok, :random_attack}
  defp do_move({:ok, move}) do
    case move do
      :healing_power -> "performs healing"
      move -> ExMonCopy.Game.Actions.attack(move)
    end
  end
end
