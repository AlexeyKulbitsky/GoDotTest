extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -450.0
const GRAVITY = 980.0
const MAX_JUMPS = 2

@export var death_zone_y: float = 900.0

var jumps_remaining = MAX_JUMPS

func _ready() -> void:
	add_to_group("player")
	var spawn = get_tree().get_first_node_in_group("spawn_point")
	if spawn:
		global_position = spawn.global_position

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		jumps_remaining = MAX_JUMPS

	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		velocity.y = JUMP_VELOCITY
		jumps_remaining -= 1

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	move_and_slide()

	if global_position.y > death_zone_y:
		die()

func die() -> void:
	var spawn = get_tree().get_first_node_in_group("spawn_point")
	if spawn:
		global_position = spawn.global_position
	velocity = Vector2.ZERO
	jumps_remaining = MAX_JUMPS
	for chaser in get_tree().get_nodes_in_group("chasers"):
		chaser.reset_position()

func apply_catapult_launch(force: float) -> void:
	velocity.y = force
	jumps_remaining = MAX_JUMPS - 1
