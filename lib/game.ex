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
  Returns game info.

  ## Examples

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
  Changes the previous game info by the updated game info.

  ## What does the game info have?
  * A map with:
    * computer player struct
    * human player struct
    * status atom
    * turn atom
  """
  def update(updated_game_info) do
    Agent.update(__MODULE__, fn _previous_game_info ->
      updated_game_info |> update_game_status
    end)
  end

  @spec fetch_player(atom) :: struct
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

  @spec turn :: atom
  @doc """
  Return whose turn it is to play.

  ## Examples

      iex> ExMonCopy.Game.turn
      :human
  """
  def turn, do: info() |> Map.get(:turn)

  # @spec update_game_status(map) :: map
  defp update_game_status(
         %{
           human: %ExMonCopy.Player{life_points: human_life},
           computer: %ExMonCopy.Player{life_points: computer_life}
         } = state
       )
       when human_life == 0 or computer_life == 0,
       do: Map.put(state, :status, :game_over)

  # ===== state =====
  #
  # iex> ExMonCopy.Game.info
  # %{
  #   computer: %ExMonCopy.Player{
  #     life_points: 100,
  #     moves: %{
  #       average_attack: :claw_slash,
  #       healing_power: :heal,
  #       random_attack: :fire_spin
  #     },
  #     name: "Charizard"
  #   },
  #   human: %ExMonCopy.Player{
  #     life_points: 100,
  #     moves: %{
  #       average_attack: :tail_whip,
  #       healing_power: :heal,
  #       random_attack: :thunderbolt
  #     },
  #     name: "Pikachu"
  #   },
  #   status: :started,
  #   turn: :human
  # }
  defp update_game_status(state) do
    state
    |> Map.put(:status, :continue)
    |> update_turn()
  end

  defp update_turn(%{turn: :human} = state), do: Map.put(state, :turn, :computer)
  defp update_turn(%{turn: :computer} = state), do: Map.put(state, :turn, :human)
end
