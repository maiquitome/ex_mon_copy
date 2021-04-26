defmodule ExMonCopy.Game.Actions do
  @doc """
  Checks whether the movement exists or not.

  ## Examples

      iex> ExMonCopy.Game.Actions.fetch_move(:thunderbolt)
      {:ok, :random_attack}

      iex> ExMonCopy.Game.Actions.fetch_move(:test)
      {:error, :test}

  """
  def fetch_move(move) do
    ExMonCopy.Game.human()
    |> Map.get(:moves)
    |> find_move(move)
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} -> move == value && {:ok, key} end)
  end
end
