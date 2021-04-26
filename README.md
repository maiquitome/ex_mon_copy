### 1. Creating the player
```bash
iex> ExMon.Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```

### 2. Creating the player in the main module
```bash
iex> ExMon.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```

### 3. Starting the game
```bash
iex> human_pokemon = ExMon.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
%ExMon.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```
```bash
iex> ExMon.start_game(human_pokemon)
{:ok, #PID<0.450.0>}
```

### 4. Printing game info
```bash
iex> ExMon.Game.info
%{
  computer: %ExMon.Player{
    life_points: 100,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMon.Player{
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
```
### 5. Printing the round message
```bash
iex> ExMon.start_game(human_pokemon)

 ===== The game is started! =====

%{
  computer: %ExMon.Player{
    life_points: 100,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMon.Player{
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
-----------------------------------
:ok
```
### 6. Returns the human pokemon data
```bash
iex> ExMonCopy.Game.human
%ExMonCopy.Player{
  life_points: 100,
  moves: %{
    average_attack: :tail_whip,
    healing_power: :heal,
    random_attack: :thunderbolt
  },
  name: "Pikachu"
}
```
### 7. Returns the computer pokemon data
```bash
iex> ExMonCopy.Game.computer
%ExMonCopy.Player{
  life_points: 100,
  moves: %{
    average_attack: :claw_slash,
    healing_power: :heal,
    random_attack: :fire_spin
  },
  name: "Charizard"
}
```
