extends AnimatableBody2D

@export var travel_distance: float = 150.0
@export var speed: float = 100.0
@export var start_moving_down: bool = true

var _start_y: float
var _direction: float

func _ready() -> void:
	_start_y = position.y
	_direction = 1.0 if start_moving_down else -1.0

	$HitArea.body_entered.connect(_on_hit_area_body_entered)

func _physics_process(delta: float) -> void:
	position.y += _direction * speed * delta

	if position.y >= _start_y + travel_distance:
		position.y = _start_y + travel_distance
		_direction = -1.0
	elif position.y <= _start_y:
		position.y = _start_y
		_direction = 1.0

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.die(true)
