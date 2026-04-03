extends Area2D

@export var inactive_color: Color = Color(0.6, 0.6, 0.6, 1)
@export var active_color: Color = Color(0.0, 1.0, 0.3, 1)

var is_active := false

static var current_checkpoint: Area2D = null

func _ready() -> void:
	add_to_group("checkpoints")
	body_entered.connect(_on_body_entered)
	$ColorRect.color = inactive_color

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	if is_active:
		return
	if current_checkpoint and current_checkpoint != self:
		current_checkpoint.deactivate()
	activate()

func activate() -> void:
	is_active = true
	current_checkpoint = self
	$ColorRect.color = active_color

func deactivate() -> void:
	is_active = false
	$ColorRect.color = inactive_color
