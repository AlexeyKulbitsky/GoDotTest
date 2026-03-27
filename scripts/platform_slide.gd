extends AnimatableBody2D

@export var travel_distance: float = 200.0
@export var speed: float = 100.0

var _start_x: float
var _direction: float = 1.0

func _ready() -> void:
	_start_x = position.x

func _physics_process(delta: float) -> void:
	position.x += _direction * speed * delta
	if _direction > 0.0 and position.x >= _start_x + travel_distance:
		position.x = _start_x + travel_distance
		_direction = -1.0
	elif _direction < 0.0 and position.x <= _start_x:
		position.x = _start_x
		_direction = 1.0
