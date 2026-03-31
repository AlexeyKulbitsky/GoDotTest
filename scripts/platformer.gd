extends Node

var score = 0

var _menu_scene: PackedScene = preload("res://scenes/menu.tscn")

func _ready() -> void:
	$CanvasLayer.update_score(score)
	for collectable in get_tree().get_nodes_in_group("collectables"):
		collectable.collected.connect(_on_collectable_collected)
	for catapult in get_tree().get_nodes_in_group("catapults"):
		catapult.player_launched.connect($CharacterBody2D.apply_catapult_launch)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		var menu = _menu_scene.instantiate()
		menu.is_pause_menu = true
		add_child(menu)
		get_tree().paused = true

func _on_collectable_collected():
	score += 1
	$CanvasLayer.update_score(score)
