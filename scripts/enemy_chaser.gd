extends CharacterBody2D

@export var detection_radius: float = 200.0
@export var speed: float = 80.0

const GRAVITY = 980.0

var _player_in_range := false
var _target: Node2D = null
var _start_position: Vector2

func _ready() -> void:
	add_to_group("chasers")
	_start_position = global_position
	var shape = CircleShape2D.new()
	shape.radius = detection_radius
	$DetectionArea/CollisionShape2D.shape = shape

func reset_position() -> void:
	global_position = _start_position
	velocity = Vector2.ZERO
	_player_in_range = false
	_target = null

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if _player_in_range and _target:
		var direction = sign(_target.global_position.x - global_position.x)
		if (direction > 0.0 and not $EdgeDetectorRight.is_colliding()) or \
			(direction < 0.0 and not $EdgeDetectorLeft.is_colliding()):
			velocity.x = 0.0
		else:
			velocity.x = direction * speed
	else:
		velocity.x = 0.0

	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		_player_in_range = true
		_target = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == _target:
		_player_in_range = false
		_target = null

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.die()
