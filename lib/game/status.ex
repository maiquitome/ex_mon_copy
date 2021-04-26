defmodule ExMonCopy.Game.Status do
  @moduledoc """
  Printing the game status.
  """

  @doc """
  Printing the round message.

  ## Examples

      iex> ExMonCopy.start_game(human_pokemon)

      ===== The game is started! =====

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
      -----------------------------------
      :ok

  """
  def print_round_message() do
    "\n ===== The game is started! ===== \n"
    |> IO.puts()

    ExMonCopy.Game.info()
    |> IO.inspect()

    "-----------------------------------"
    |> IO.puts()
  end
end
