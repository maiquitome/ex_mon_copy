defmodule ExMonCopy.Game.Actions.Heal do
  @healing_power 18..25

  @spec restores_life_points(:computer | :human) :: :ok
  def restores_life_points(player) do
    player
    |> ExMonCopy.Game.fetch_player()
    |> Map.get(:life_points)
    |> calculates_life_points()
    |> updates_life_points(player)
  end

  defp calculates_life_points(current_life_points),
    do: current_life_points + Enum.random(@healing_power)

  @spec updates_life_points(number(), :human | :computer) :: :ok

  # if life_points are greater than 100 then it becomes 100
  defp updates_life_points(changed_life_points, player)
       when changed_life_points > 100,
       do: updates_player_life(player, 100)

  # if life points are smaller than 100 then keep the value
  defp updates_life_points(changed_life_points, player)
       when changed_life_points < 100,
       do: updates_player_life(player, changed_life_points)

  @spec updates_player_life(:computer | :human, number()) :: :ok
  defp updates_player_life(player, updated_life_points) do
    player
    |> ExMonCopy.Game.fetch_player()
    |> Map.put(:life_points, updated_life_points)
    |> update_game(player, updated_life_points)
  end

  @spec update_game(
          %ExMonCopy.Player{
            life_points: number(),
            moves: %{
              average_attack: atom(),
              random_attack: atom(),
              healing_power: atom()
            },
            name: String.t()
          },
          :human | :computer,
          number()
        ) :: :ok
  defp update_game(player_struct, player_name, updated_life_points) do
    ExMonCopy.Game.info()
    |> Map.put(player_name, player_struct)
    |> ExMonCopy.Game.update()

    ExMonCopy.Game.Status.print_move_message(player_name, :healing, updated_life_points)
  end
end
