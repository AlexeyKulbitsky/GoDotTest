extends RigidBody2D

@export var detection_width: float = 80.0
@export var fall_delay: float = 0.5
@export var block_width: float = 50.0
@export var block_height: float = 50.0

var _start_position: Vector2
var _has_fallen := false
var _falling := false

func _ready() -> void:
	add_to_group("falling_blocks")
	_start_position = global_position
	freeze = true
	contact_monitor = true
	max_contacts_reported = 4

	$BlockShape.shape = $BlockShape.shape.duplicate()
	$BlockShape.shape.size = Vector2(block_width, block_height)
	$ColorRect.offset_left = -block_width / 2.0
	$ColorRect.offset_top = -block_height
	$ColorRect.offset_right = block_width / 2.0
	$ColorRect.offset_bottom = 0.0

	$DetectionZone/DetectionShape.shape = $DetectionZone/DetectionShape.shape.duplicate()
	$DetectionZone/DetectionShape.shape.size = Vector2(detection_width, 600.0)
	$DetectionZone/DetectionShape.position = Vector2(0, 300.0 + block_height / 2.0)

	$DetectionZone.body_entered.connect(_on_detection_zone_body_entered)
	body_entered.connect(_on_body_entered)

func _on_detection_zone_body_entered(body: Node2D) -> void:
	if _has_fallen or _falling:
		return
	if body is CharacterBody2D and body.is_in_group("player"):
		_falling = true
		await get_tree().create_timer(fall_delay).timeout
		if not is_inside_tree():
			return
		freeze = false
		_has_fallen = true
		_falling = false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.die(true)

func reset_position() -> void:
	freeze = true
	_has_fallen = false
	_falling = false
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	global_position = _start_position
	rotation = 0.0
