defmodule ExMonCopy.Player do
  @moduledoc """
  Create the player.

  ## The player must have:
    * life points (default: 100)
    * name
    * moves:
      * Average attack causing between (18-25) damage;
      * Random attack causing between (10-35) damage;
      * Healing power, healing between (18-25) of life.
  """
  @life_points 100
  @required_keys [:life_points, :name, :moves]

  @enforce_keys @required_keys

  defstruct @required_keys

  @doc """
  Create Player.

  ## Examples

      iex> ExMonCopy.Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
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
  def build(name, random_attack, average_attack, healing_power) do
    %ExMonCopy.Player{
      life_points: @life_points,
      moves: %{
        average_attack: average_attack,
        healing_power: healing_power,
        random_attack: random_attack
      },
      name: name
    }
  end
end
