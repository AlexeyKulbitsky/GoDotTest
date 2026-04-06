extends CharacterBody2D

@export var jump_force: float = -500.0
@export var jump_interval: float = 2.0

const GRAVITY = 980.0

var _start_position: Vector2
var _jump_timer: Timer

func _ready() -> void:
	add_to_group("bouncers")
	_start_position = global_position

	_jump_timer = Timer.new()
	_jump_timer.wait_time = jump_interval
	_jump_timer.timeout.connect(_on_jump_timer_timeout)
	add_child(_jump_timer)
	_jump_timer.start()

func reset_position() -> void:
	global_position = _start_position
	velocity = Vector2.ZERO
	_jump_timer.start(jump_interval)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	velocity.x = 0.0
	move_and_slide()

func _on_jump_timer_timeout() -> void:
	if is_on_floor():
		velocity.y = jump_force
	_jump_timer.start(jump_interval)

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.on_enemy_contact(self)
