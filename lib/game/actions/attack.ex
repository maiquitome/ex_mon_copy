defmodule ExMonCopy.Game.Actions.Attack do
  @average_attack 18..25
  @random_attack 10..35

  def attack_opponent(opponent_atom, move_atom) do
    damage = calculate_power(move_atom)

    opponent_atom
    |> ExMonCopy.Game.fetch_player()
    |> Map.get(:life_points)
    |> calculate_life_damage(damage)
    |> update_opponent_life(opponent_atom)
  end

  defp calculate_power(:average_attack), do: Enum.random(@average_attack)
  defp calculate_power(:random_attack), do: Enum.random(@random_attack)

  defp calculate_life_damage(life_points, damage) when life_points - damage < 0, do: 0
  defp calculate_life_damage(life_points, damage), do: life_points - damage

  @typedoc """
  A current opponent struct is a human or computer struct, e.g.

  %ExMonCopy.Player{
    life_points: 100,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  }
  """
  @type current_opponent_struct :: struct

  defp update_opponent_life(remaining_life_points, opponent_atom) do
    updated_opponent_struct =
      opponent_atom
      |> ExMonCopy.Game.fetch_player()
      |> Map.put(:life_points, remaining_life_points)

    updated_opponent_struct
    |> update_player_state(opponent_atom)
  end

  @type human_or_computer :: atom
  @type updated_player :: struct
  defp update_player_state(updated_player, human_or_computer) do
    current_life_points = ExMonCopy.Game.info()[human_or_computer].life_points

    damage = current_life_points - updated_player.life_points

    ExMonCopy.Game.info()
    |> Map.put(human_or_computer, updated_player)
    |> ExMonCopy.Game.update()

    ExMonCopy.Game.Status.print_move_message(human_or_computer, :attack, damage)
  end
end
