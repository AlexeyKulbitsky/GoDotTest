extends StaticBody2D

signal player_launched(launch_force: float)

@export var launch_force: float = -1000.0
@export var cooldown_time: float = 1.0

var _on_cooldown := false

func _ready() -> void:
	add_to_group("catapults")

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not _on_cooldown:
		_on_cooldown = true
		player_launched.emit(launch_force)
		await get_tree().create_timer(cooldown_time).timeout
		_on_cooldown = false
