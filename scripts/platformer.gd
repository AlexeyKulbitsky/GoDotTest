extends Node

var score = 0

func _ready() -> void:
	$CanvasLayer.update_score(score)
	for collectable in get_tree().get_nodes_in_group("collectables"):
		collectable.collected.connect(_on_collectable_collected)

func _on_collectable_collected():
	score += 1
	$CanvasLayer.update_score(score)
