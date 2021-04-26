defmodule ExMonCopy.Game.Actions.Attack do
  @average_attack 18..25
  @random_attack 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)

    opponent
    |> ExMonCopy.Game.fetch_player()
    |> Map.get(:life_points)
    |> calculate_life_damage(damage)
    |> update_opponent_life(opponent)
  end

  defp calculate_power(:average_attack), do: Enum.random(@average_attack)
  defp calculate_power(:random_attack), do: Enum.random(@random_attack)

  defp calculate_life_damage(life_points, damage) when life_points - damage < 0, do: 0
  defp calculate_life_damage(life_points, damage), do: life_points - damage

  defp update_opponent_life(remaining_life_points, opponent) do
    opponent
    |> ExMonCopy.Game.fetch_player()
    |> Map.put(:life_points, remaining_life_points)
  end
end
