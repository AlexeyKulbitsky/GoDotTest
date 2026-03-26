extends Area2D

signal collected

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	add_to_group("collectables")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		collected.emit()
		queue_free()
