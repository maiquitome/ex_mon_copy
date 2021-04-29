defmodule ExMonCopy.Game.Actions do
  @moduledoc """
  Player actions.
  """

  @spec attack(:average_attack | :random_attack) :: :ok
  @doc """
  Attack the opponent.
  """
  def attack(move_type) do
    case ExMonCopy.Game.turn() do
      :human ->
        ExMonCopy.Game.Actions.Attack.attack_opponent(:computer, move_type)

      :computer ->
        ExMonCopy.Game.Actions.Attack.attack_opponent(:human, move_type)
    end
  end

  @doc """
  Restores life points from the human or computer.
  """
  @spec heal :: any
  def heal do
    case ExMonCopy.Game.turn() do
      :human ->
        ExMonCopy.Game.Actions.Heal.restores_life_points(:human)

      :computer ->
        ExMonCopy.Game.Actions.Heal.restores_life_points(:computer)
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
