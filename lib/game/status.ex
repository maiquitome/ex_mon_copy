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
    "\n===== The game is started! =====\n"
    |> IO.puts()

    ExMonCopy.Game.info()
    |> IO.inspect()

    "\n----------------------------------\n"
    |> IO.puts()
  end

  @spec print_round_message(%{
          :status => :continue,
          :turn => :computer | :human,
          optional(any) => any
        }) :: :ok
  def print_round_message(%{status: :continue, turn: :human} = info) do
    "\n========= It's your turn to play! =========\n"
    |> IO.puts()

    info
    |> IO.inspect()

    "\n--------------------------------------------\n"
    |> IO.puts()
  end

  def print_round_message(%{status: :continue, turn: :computer} = info) do
    "\n===== It's the computer's turn to play =====\n"
    |> IO.puts()

    info
    |> IO.inspect()

    "\n------------------------------------------\n"
    |> IO.puts()
  end

  def print_round_message(
        %{status: :game_over, computer: %ExMonCopy.Player{life_points: 0}} = info
      ) do
    info |> IO.inspect()

    "
    ============================================
    ============= The game is over! ============
    ============================================
    ================ YOU WIN :) ================
    ============================================
    "
    |> IO.puts()
  end

  def print_round_message(%{status: :game_over, human: %ExMonCopy.Player{life_points: 0}} = info) do
    info |> IO.inspect()

    "
    ============================================
    ============= The game is over! ============
    ============================================
    ==============  YOU LOSE :'(  ==============
    ============================================
    "
    |> IO.puts()
  end

  def print_wrong_move_message(move) do
    "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
               Invalid Move: #{move}
     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    |> IO.puts()
  end

  @spec print_move_message(:computer | :human, :attack | :healing, number()) :: :ok

  def print_move_message(:computer, :attack, life_points) do
    "\n===== You attacked the computer causing #{life_points} damage. =====\n"
    |> IO.puts()
  end

  def print_move_message(:human, :attack, life_points) do
    "\n===== The computer attacked you causing #{life_points} damage. =====\n"
    |> IO.puts()
  end

  def print_move_message(:computer, :healing, life_points) do
    "\n===== The computer recovered itself to #{life_points} life points. =====\n"
    |> IO.puts()
  end

  def print_move_message(:human, :healing, life_points) do
    "\n===== You recovered yourself to #{life_points} life points. =====\n"
    |> IO.puts()
  end
end
