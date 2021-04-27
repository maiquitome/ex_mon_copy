defmodule ExMonCopy.Game.Actions do
  @moduledoc """
  Player actions.
  """

  @spec attack(:average_attack | :random_attack) :: :ok
  @doc """
  Attack the opponent.

  ## Examples

      iex> ExMonCopy.make_move(:thunderbolt)

        ===== You attacked the computer causing 30 damage. =====

      :ok

  """
  def attack(move) do
    case ExMonCopy.Game.turn() do
      :human ->
        ExMonCopy.Game.Actions.Attack.attack_opponent(:computer, move)

      :computer ->
        ExMonCopy.Game.Actions.Attack.attack_opponent(:human, move)
    end
  end

  @doc """
  Checks whether the movement exists or not.

  ## Examples

      iex> ExMonCopy.Game.Actions.fetch_move(:thunderbolt)
      {:ok, :random_attack}

      iex> ExMonCopy.Game.Actions.fetch_move(:test)
      {:error, :test}

  """
  def fetch_move(move) do
    ExMonCopy.Game.fetch_player(:human)
    |> Map.get(:moves)
    |> find_move(move)
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} -> move == value && {:ok, key} end)
  end
end
