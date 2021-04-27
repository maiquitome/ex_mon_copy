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
    "
    ===== The game is started! =====
    "
    |> IO.puts()

    ExMonCopy.Game.info()
    |> IO.inspect()

    "
    ---------------------------------
    "
    |> IO.puts()
  end

  def print_wrong_move_message(move) do
    "
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          Invalid Move: #{move}
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    "
    |> IO.puts()
  end

  def print_move_message(:computer, :attack, damage) do
    "
    ===== You attacked the computer causing #{damage} damage. =====
    "
    |> IO.puts()
  end

  def print_move_message(:human, :attack, damage) do
    "
    ===== The computer attacked you causing #{damage} damage. =====
    "
    |> IO.puts()
  end
end
