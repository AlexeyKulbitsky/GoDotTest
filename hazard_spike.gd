extends Area2D

@export var active_duration: float = 2.0
@export var inactive_duration: float = 2.0

var _is_active := false
var _cycle_timer: Timer
var _color_rect: ColorRect

const ACTIVE_COLOR := Color(1.0, 0.0, 0.0, 1.0)
const INACTIVE_COLOR := Color(0.5, 0.5, 0.5, 1.0)

func _ready() -> void:
	add_to_group("spike_traps")
	_color_rect = $ColorRect
	_color_rect.color = INACTIVE_COLOR

	_cycle_timer = Timer.new()
	_cycle_timer.one_shot = true
	_cycle_timer.timeout.connect(_on_cycle_timer_timeout)
	add_child(_cycle_timer)
	_cycle_timer.start(inactive_duration)

	body_entered.connect(_on_body_entered)

func _on_cycle_timer_timeout() -> void:
	if _is_active:
		_is_active = false
		_color_rect.color = INACTIVE_COLOR
		_cycle_timer.start(inactive_duration)
	else:
		_is_active = true
		_color_rect.color = ACTIVE_COLOR
		_cycle_timer.start(active_duration)
		for body in get_overlapping_bodies():
			if body is CharacterBody2D and body.is_in_group("player"):
				body.die(true)

func _on_body_entered(body: Node2D) -> void:
	if _is_active and body is CharacterBody2D and body.is_in_group("player"):
		body.die(true)

func reset_cycle() -> void:
	_is_active = false
	_color_rect.color = INACTIVE_COLOR
	_cycle_timer.start(inactive_duration)
