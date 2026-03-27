extends AnimatableBody2D

@export var travel_distance: float = 300.0
@export var return_delay: float = 2.0
@export var speed: float = 100.0

var _start_y: float
var _moving_up := false
var _moving_down := false
var _waiting := false

func _ready() -> void:
	_start_y = position.y

func _physics_process(delta: float) -> void:
	if _moving_up:
		position.y -= speed * delta
		if position.y <= _start_y - travel_distance:
			position.y = _start_y - travel_distance
			_moving_up = false
			_start_wait()
	elif _moving_down:
		position.y += speed * delta
		if position.y >= _start_y:
			position.y = _start_y
			_moving_down = false

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not _moving_up and not _moving_down and not _waiting:
		_moving_up = true

func _start_wait() -> void:
	_waiting = true
	await get_tree().create_timer(return_delay).timeout
	_waiting = false
	_moving_down = true
