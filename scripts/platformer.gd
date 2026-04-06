extends Node

var _menu_scene: PackedScene = preload("res://scenes/menu.tscn")
var _previous_lives: int = -1

func _ready() -> void:
	$CanvasLayer.update_score(GameManager.score)
	$CanvasLayer.update_lives(GameManager.get_lives())
	_previous_lives = GameManager.get_lives()
	for collectable in get_tree().get_nodes_in_group("collectables"):
		collectable.collected.connect(_on_collectable_collected)
	for catapult in get_tree().get_nodes_in_group("catapults"):
		catapult.player_launched.connect($CharacterBody2D.apply_catapult_launch)

func _process(_delta: float) -> void:
	var current_lives := GameManager.get_lives()
	if current_lives != _previous_lives:
		_previous_lives = current_lives
		$CanvasLayer.update_lives(current_lives)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		var menu = _menu_scene.instantiate()
		menu.is_pause_menu = true
		add_child(menu)
		get_tree().paused = true

func _on_collectable_collected():
	GameManager.increment_score()
	$CanvasLayer.update_score(GameManager.score)
