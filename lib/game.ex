defmodule ExMonCopy.Game do
  @moduledoc """
  Stores game information.
  """
  use Agent

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
  def start(computer, human) do
    initial_value = %{
      computer: computer,
      human: human,
      turn: :human,
      # ou :computer
      status: :started
      # ou :continue, :game_over
    }

    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @doc """
  Printing game info.

  Examples

      iex> ExMonCopy.Game.info
      %{
        computer: %ExMonCopy.Player{
          life_points: 100,
          moves: %{
            average_attack: :claw_slash,
            healing_power: :heal,
            random_attack: :fire_spin
          },
          name: "Charizard"
        },
        human: %ExMonCopy.Player{
          life_points: 100,
          moves: %{
            average_attack: :tail_whip,
            healing_power: :heal,
            random_attack: :thunderbolt
          },
          name: "Pikachu"
        },
        status: :started,
        turn: :human
      }

  """
  def info do
    Agent.get(__MODULE__, & &1)
  end

  @doc """
  Returns the human or computer pokemon data.

  ## Examples

      iex> ExMonCopy.Game.fetch_player(:computer)
      %ExMonCopy.Player{
        life_points: 100,
        moves: %{
          average_attack: :claw_slash,
          healing_power: :heal,
          random_attack: :fire_spin
        },
        name: "Charizard"
      }

  """
  def fetch_player(player), do: info() |> Map.get(player)

  @doc """
  Return whose turn it is to play.
  """
  def turn, do: info() |> Map.get(:turn)
end
