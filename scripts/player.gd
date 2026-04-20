extends CharacterBody2D

const BASE_SPEED = 300.0
const BASE_JUMP_VELOCITY = -450.0
const GRAVITY = 980.0
const MAX_JUMPS = 2

@export var death_zone_y: float = 900.0
@export var boosted_speed: float = 500.0
@export var boosted_jump_velocity: float = -650.0

var jumps_remaining = MAX_JUMPS
var is_powered_up := false

var _current_speed := BASE_SPEED
var _current_jump_velocity := BASE_JUMP_VELOCITY
var _powerup_timer: Timer
var _spawn_position: Vector2

func _ready() -> void:
	add_to_group("player")
	var checkpoint_script = load("res://scripts/checkpoint.gd")
	checkpoint_script.current_checkpoint = null
	var spawn = get_tree().get_first_node_in_group("spawn_point")
	if spawn:
		global_position = spawn.global_position
		_spawn_position = spawn.global_position
	else:
		_spawn_position = global_position
	_powerup_timer = Timer.new()
	_powerup_timer.one_shot = true
	_powerup_timer.timeout.connect(_on_powerup_expired)
	add_child(_powerup_timer)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		jumps_remaining = MAX_JUMPS

	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		velocity.y = _current_jump_velocity
		jumps_remaining -= 1

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * _current_speed

	move_and_slide()

	if global_position.y > death_zone_y:
		die()

func activate_powerup(duration: float) -> void:
	is_powered_up = true
	_current_speed = boosted_speed
	_current_jump_velocity = boosted_jump_velocity
	$ColorRect.color = Color(0, 1, 1, 1)
	_powerup_timer.start(duration)

func _on_powerup_expired() -> void:
	is_powered_up = false
	_current_speed = BASE_SPEED
	_current_jump_velocity = BASE_JUMP_VELOCITY
	$ColorRect.color = Color(1, 1, 0.21568628, 1)

func on_enemy_contact(enemy: Node2D) -> void:
	if is_powered_up:
		enemy.queue_free()
	else:
		die()

func die(force: bool = false) -> void:
	if is_powered_up and not force:
		return
	GameManager.lose_life()
	if GameManager.get_lives() <= 0:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")
		return
	var checkpoint_script = load("res://scripts/checkpoint.gd")
	if checkpoint_script.current_checkpoint:
		global_position = checkpoint_script.current_checkpoint.global_position
	else:
		global_position = _spawn_position
	velocity = Vector2.ZERO
	jumps_remaining = MAX_JUMPS
	for chaser in get_tree().get_nodes_in_group("chasers"):
		chaser.reset_position()
	for bouncer in get_tree().get_nodes_in_group("bouncers"):
		bouncer.reset_position()
	for spike in get_tree().get_nodes_in_group("spike_traps"):
		spike.reset_cycle()
	for block in get_tree().get_nodes_in_group("falling_blocks"):
		block.reset_position()

func apply_catapult_launch(force: float) -> void:
	velocity.y = force
	jumps_remaining = MAX_JUMPS - 1
