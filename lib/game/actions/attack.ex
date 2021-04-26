defmodule ExMonCopy.Game.Actions.Attack do
  @average_attack 18..25
  @random_attack 10..35

  def attack_opponent(opponent, move) do
    damage = calculate_power(move)
  end

  defp calculate_power(:average_attack), do: Enum.random(@average_attack)
  defp calculate_power(:random_attack), do: Enum.random(@random_attack)
end
