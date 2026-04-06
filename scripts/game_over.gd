extends CanvasLayer

const GAMEPLAY_SCENE := "res://scenes/level_1.tscn"

@onready var _score_label := $Background/VBoxContainer/ScoreLabel
@onready var _play_again_button := $Background/VBoxContainer/PlayAgainButton
@onready var _exit_button := $Background/VBoxContainer/ExitButton

func _ready() -> void:
	_score_label.text = "Score: " + str(GameManager.score)
	_play_again_button.pressed.connect(_on_play_again_pressed)
	_exit_button.pressed.connect(_on_exit_pressed)

func _on_play_again_pressed() -> void:
	GameManager.reset_score()
	GameManager.reset_lives()
	get_tree().change_scene_to_file(GAMEPLAY_SCENE)

func _on_exit_pressed() -> void:
	get_tree().quit()
