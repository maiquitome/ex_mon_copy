defmodule ExMonCopy do
  @moduledoc """
  Documentation for `ExMonCopy`.
  """

  @doc """
  Create Player.

  ## Examples

      iex> ExMonCopy.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
      %ExMon.Player{
        life_points: 100,
        moves: %{
          average_attack: :tail_whip,
          healing_power: :heal,
          random_attack: :thunderbolt
        },
        name: "Pikachu"
      }

  """
  def create_player(name, random_attack, average_attack, healing_power) do
    ExMonCopy.Player.build(name, random_attack, average_attack, healing_power)
  end
end
