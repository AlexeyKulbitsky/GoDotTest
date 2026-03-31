extends StaticBody2D

@export var fire_interval: float = 2.0

var _projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")

func _ready() -> void:
	$FireTimer.wait_time = fire_interval
	$FireTimer.start()

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.is_in_group("player"):
		body.on_enemy_contact(self)

func _on_fire_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		return
	var direction = sign(player.global_position.x - global_position.x)
	if direction == 0.0:
		direction = 1.0
	var projectile = _projectile_scene.instantiate()
	projectile.global_position = global_position + Vector2(direction * 30.0, -15.0)
	projectile.direction = direction
	get_tree().current_scene.add_child(projectile)
