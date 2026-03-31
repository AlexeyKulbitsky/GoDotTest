extends Area2D

@export var speed: float = 400.0

var direction: float = 1.0

func _physics_process(delta: float) -> void:
	position.x += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		if not body.is_powered_up:
			body.die()
	queue_free()
