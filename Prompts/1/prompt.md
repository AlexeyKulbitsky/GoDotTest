Hey! I have a small task for you, estimated at around 2 hours. We are currently evaluating Godot 4.x as a potential engine for 2D platformer development, so this task is part of that assessment — keep that in mind as you work through it.

Create a new project and name the main scene file `platformer.tscn` with its accompanying script `platformer.gd`. The scene is a simple 2D platformer setup. Add a ground and 2 to 3 floating platforms using StaticBody2D nodes. The player character should be a plain colored square using CharacterBody2D with a RectangleShape2D — no sprites needed. Name the player scene `player.tscn` with its script `player.gd`.

The player needs to move left and right with A and D, and jump with W or Space. Implement double jump — the player gets one extra jump while airborne, and landing on any surface resets that counter. On the third attempted jump mid-air, nothing should happen.

Scatter 2 or 3 collectables around the scene using Area2D nodes — simple colored shapes are fine. When the player touches one, it should disappear and increment the score by one. Name the collectable scene `collectable.tscn` with its script `collectable.gd`.

Add a basic UI using a CanvasLayer with a single Label node showing the current score in the top left corner of the screen, something like "Score: 0". The label should update in real time as collectables are picked up. Name the UI scene `ui.tscn` with its script `ui.gd`.

No audio, no game over screen, no extra polish — just the mechanics and the score counter working correctly and cleanly. Make sure the project runs without errors or warnings. Keep the code readable, use clear variable names, and add a comment or two where the logic isn't immediately obvious. Ping me if you get stuck on anything!