extends Area2D

@export var duration: float = 8.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.activate_powerup(duration)
		GameManager.restore_life()
		queue_free()
