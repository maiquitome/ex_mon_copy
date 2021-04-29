defmodule ExMonCopyTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMonCopy.Player

  describe "create_player/4" do
    test "Creates the player." do
      expected_response = %Player{
        life_points: 100,
        moves: %{
          average_attack: :tail_whip,
          healing_power: :heal,
          random_attack: :thunderbolt
        },
        name: "Pikachu"
      }

      assert ExMonCopy.create_player(
               "Pikachu",
               :thunderbolt,
               :tail_whip,
               :heal
             ) == expected_response
    end
  end

  describe "start_game/1" do
    test "Starts the game." do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)

      messages =
        capture_io(fn ->
          assert ExMonCopy.start_game(human) == :ok
        end)

      assert messages =~ "The game is started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :human"
    end
  end

  describe "make_move/1" do
    setup do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)

      capture_io(fn ->
        ExMonCopy.start_game(human)
      end)

      :ok
    end

    test "When the move is valid, you (human) do the move and the computer too" do
      messages =
        capture_io(fn ->
          ExMonCopy.make_move(:thunderbolt)
        end)

      assert messages =~ "You attacked the computer" || "You recovered yourself"

      assert messages =~ "turn: :computer"
      assert messages =~ "It's the computer's turn to play"
      assert messages =~ "The computer attacked you" || "The computer recovered itself"

      assert messages =~ "turn: :human"
      assert messages =~ "It's your turn to play"
      assert messages =~ "status: :continue"
    end

    test "When the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMonCopy.make_move(:nonexistent_movement)
        end)

      assert messages =~ "Invalid Move: nonexistent_movement"
    end

    test "When the game is over, returns a message" do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)

      capture_io(fn ->
        ExMonCopy.start_game(human)
      end)

      %{
        computer: %ExMonCopy.Player{
          life_points: 0,
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
      |> ExMonCopy.Game.update()

      messages =
        capture_io(fn ->
          ExMonCopy.make_move(:thunderbolt)
          ExMonCopy.make_move(:heal)
          ExMonCopy.make_move(:nonexistent_movement)
        end)

      assert messages =~ "life_points: 0"
      assert messages =~ "status: :game_over"
      assert messages =~ "The game is over!"
    end
  end
end
