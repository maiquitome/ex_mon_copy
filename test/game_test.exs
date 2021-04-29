defmodule ExMonCopy.GameTest do
  use ExUnit.Case
  # doctest ExMonCopy

  import ExUnit.CaptureIO

  alias ExMonCopy.{Game, Player}
  alias ExMonCopy.Game.Actions

  describe "start/2" do
    test "starts the game state" do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
      computer = Player.build("Charizard", :fire_spin, :claw_slash, :heal)

      # testar se a expressão é verdadeira
      assert {:ok, _pid} = Game.start(computer, human)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
      computer = Player.build("Charizard", :fire_spin, :claw_slash, :heal)

      Game.start(computer, human)

      expected_response = %{
        computer: %Player{
          life_points: 100,
          moves: %{
            average_attack: :claw_slash,
            healing_power: :heal,
            random_attack: :fire_spin
          },
          name: "Charizard"
        },
        human: %Player{
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

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "changes the previous game state by the updated game state" do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
      computer = Player.build("Charizard", :fire_spin, :claw_slash, :heal)

      Game.start(computer, human)

      expected_response = %{
        computer: %Player{
          life_points: 100,
          moves: %{
            average_attack: :claw_slash,
            healing_power: :heal,
            random_attack: :fire_spin
          },
          name: "Charizard"
        },
        human: %Player{
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

      assert Game.info() == expected_response

      new_state = %{
        computer: %Player{
          life_points: 85,
          moves: %{
            average_attack: :claw_slash,
            healing_power: :heal,
            random_attack: :fire_spin
          },
          name: "Charizard"
        },
        human: %Player{
          life_points: 50,
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

      assert Game.update(new_state) == :ok

      expected_response = %{new_state | status: :continue, turn: :computer}

      assert Game.info() == expected_response
    end
  end

  describe "fetch_player/1" do
    test "Returns the human or computer pokemon data" do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
      computer = Player.build("Charizard", :fire_spin, :claw_slash, :heal)

      Game.start(computer, human)

      expected_response = %Player{
        life_points: 100,
        moves: %{
          average_attack: :claw_slash,
          healing_power: :heal,
          random_attack: :fire_spin
        },
        name: "Charizard"
      }

      assert Game.fetch_player(:computer) == expected_response

      expected_response = %ExMonCopy.Player{
        life_points: 100,
        moves: %{
          average_attack: :tail_whip,
          healing_power: :heal,
          random_attack: :thunderbolt
        },
        name: "Pikachu"
      }

      assert Game.fetch_player(:human) == expected_response
    end
  end

  describe "turn/0" do
    test "Return whose turn it is to play." do
      human = Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
      computer = Player.build("Charizard", :fire_spin, :claw_slash, :heal)

      Game.start(computer, human)

      assert Game.turn() == :human

      message =
        capture_io(fn ->
          assert Actions.attack(:random_attack)
        end)

      assert message =~ "You attacked the computer causing"

      assert Game.turn() == :computer
    end
  end
end
