### 1. Creating the player
```bash
iex> ExMonCopy.Player.build("Pikachu", :thunderbolt, :tail_whip, :heal)
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

### 2. Creating the player in the main module
```bash
iex> ExMonCopy.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
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

### 3. Starting the game
```bash
iex> human_pokemon = ExMonCopy.create_player("Pikachu", :thunderbolt, :tail_whip, :heal)
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
```bash
iex> ExMonCopy.start_game(human_pokemon)
{:ok, #PID<0.450.0>}
```

### 4. Printing game info
```bash
iex> ExMonCopy.Game.info
%{
  computer: %ExMonCopy.Player{
    life_points: 100,
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
```
### 5. Printing the round message
```bash
iex> ExMonCopy.start_game(human_pokemon)

 ===== The game is started! =====

%{
  computer: %ExMonCopy.Player{
    life_points: 100,
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
-----------------------------------
:ok
```
### 6. Returns the human pokemon data
```bash
iex> ExMonCopy.Game.fetch_player(:human)
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
iex> ExMonCopy.Game.fetch_player(:computer)
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

### 8. Checks whether the movement exists or not
exists
```bash
iex> ExMonCopy.Game.Actions.fetch_move(:thunderbolt)
{:ok, :random_attack}
```
not
```bash
iex> ExMonCopy.Game.Actions.fetch_move(:test)
{:error, :test}
```

### 9. Printing error or success message when making the move.
```bash
iex> ExMonCopy.make_move(:teste)

    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          Invalid Move: teste
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

:ok
```
```bash
iex> ExMonCopy.make_move(:heal)
"performs healing"
```
```bash
iex> ExMonCopy.make_move(:thunderbolt)
"performs attack"
```

### 10. Printing a random number when attacking
```bash
iex> ExMonCopy.make_move(:thunderbolt)
26
iex> ExMonCopy.make_move(:thunderbolt)
15
iex> ExMonCopy.make_move(:thunderbolt)
10
```

### 11. Causing damage to the opponent
```bash
iex> ExMonCopy.make_move(:thunderbolt)
%ExMonCopy.Player{
  life_points: 75,
  moves: %{
    average_attack: :claw_slash,
    healing_power: :heal,
    random_attack: :fire_spin
  },
  name: "Charizard"
}
```
```bash
iex> ExMonCopy.make_move(:thunderbolt)
%ExMonCopy.Player{
  life_points: 85,
  moves: %{
    average_attack: :claw_slash,
    healing_power: :heal,
    random_attack: :fire_spin
  },
  name: "Charizard"
}
```
!!! Elixir is immutable, so we always need to _reassign_ the values
