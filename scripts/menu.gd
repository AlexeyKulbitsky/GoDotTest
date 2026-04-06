extends CanvasLayer

const GAMEPLAY_SCENE := "res://scenes/level_1.tscn"

var is_pause_menu := false

@onready var _background := $Background
@onready var _play_button := $Background/VBoxContainer/PlayButton
@onready var _resume_button := $Background/VBoxContainer/ResumeButton
@onready var _restart_button := $Background/VBoxContainer/RestartButton
@onready var _exit_button := $Background/VBoxContainer/ExitButton

func _ready() -> void:
	_play_button.visible = not is_pause_menu
	_resume_button.visible = is_pause_menu
	_restart_button.visible = is_pause_menu
	if is_pause_menu:
		_background.color = Color(0.05, 0.05, 0.1, 0.85)
	_play_button.pressed.connect(_on_play_pressed)
	_resume_button.pressed.connect(_on_resume_pressed)
	_restart_button.pressed.connect(_on_restart_pressed)
	_exit_button.pressed.connect(_on_exit_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if is_pause_menu and event.is_action_pressed("ui_cancel"):
		_resume()
		get_viewport().set_input_as_handled()

func _on_play_pressed() -> void:
	GameManager.reset_score()
	GameManager.reset_lives()
	get_tree().change_scene_to_file(GAMEPLAY_SCENE)

func _on_resume_pressed() -> void:
	_resume()

func _on_restart_pressed() -> void:
	GameManager.reset_score()
	GameManager.reset_lives()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _resume() -> void:
	get_tree().paused = false
	queue_free()
