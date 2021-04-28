defmodule ExMonCopy do
  @moduledoc """
  Documentation for `ExMonCopy`.
  """
  @computer_name "Charizard"
  @computer_moves [:average_attack, :random_attack, :healing_power]

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

  @spec make_move(:average_attack | :random_attack | :healing_power) :: :ok
  @doc """
  Attack the opponent or heal yourself.

  ## Examples

      iex> ExMonCopy.make_move(:thunderbolt)

        ===== You attacked the computer causing 30 damage. =====

      :ok

  """
  def make_move(move) do
    move
    |> ExMonCopy.Game.Actions.fetch_move()
    |> do_move()

    computer_move(ExMonCopy.Game.info())
  end

  @spec do_move({:error, atom} | {:ok, :average_attack | :healing_power | :random_attack}) :: :ok
  defp do_move({:error, move}), do: ExMonCopy.Game.Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :healing_power -> ExMonCopy.Game.Actions.heal()
      move -> ExMonCopy.Game.Actions.attack(move)
    end

    ExMonCopy.Game.info()
    |> ExMonCopy.Game.Status.print_round_message()
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    {:ok, Enum.random(@computer_moves)}
    |> do_move()
  end

  defp computer_move(_), do: :ok
end
