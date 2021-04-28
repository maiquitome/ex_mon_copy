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

### 12. Changing the game state
```bash
iex> ExMonCopy.make_move(:thunderbolt)

===== You attacked the computer causing 34 damage. =====


===== It is the computer turn to play =====

%{
  computer: %ExMonCopy.Player{
    life_points: 66,
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
  status: :continue,
  turn: :computer
}

------------------------------------------
:ok
```
```bash
iex> ExMonCopy.make_move(:thunderbolt)

===== The computer attacked you causing 11 damage. =====


========= It is your turn to play! =========

%{
  computer: %ExMonCopy.Player{
    life_points: 66,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMonCopy.Player{
    life_points: 89,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :continue,
  turn: :human
}

--------------------------------------------

:ok
```
### 13. Creating the healing action

```bash
iex> ExMonCopy.make_move(:heal)

===== You recovered yourself to 68 life points. =====


===== It is the computer turn to play =====

%{
  computer: %ExMonCopy.Player{
    life_points: 59,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMonCopy.Player{
    life_points: 68,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :continue,
  turn: :computer
}

------------------------------------------

:ok
```
### 14. Creating the computer turn
```bash
iex> ExMonCopy.make_move(:thunderbolt)

===== You attacked the computer causing 12 damage. =====


===== It is the computer turn to play =====

%{
  computer: %ExMonCopy.Player{
    life_points: 88,
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
  status: :continue,
  turn: :computer
}

------------------------------------------


===== The computer attacked you causing 22 damage. =====


========= It is your turn to play! =========

%{
  computer: %ExMonCopy.Player{
    life_points: 88,
    moves: %{
      average_attack: :claw_slash,
      healing_power: :heal,
      random_attack: :fire_spin
    },
    name: "Charizard"
  },
  human: %ExMonCopy.Player{
    life_points: 78,
    moves: %{
      average_attack: :tail_whip,
      healing_power: :heal,
      random_attack: :thunderbolt
    },
    name: "Pikachu"
  },
  status: :continue,
  turn: :human
}

--------------------------------------------

:ok
```
