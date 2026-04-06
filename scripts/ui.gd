extends CanvasLayer

const LIFE_INDICATOR_SIZE := 24.0
const LIFE_INDICATOR_GAP := 8.0
const LIFE_COLOR := Color(1, 0.2, 0.2, 1)

@onready var _life_container := $LifeContainer

func update_score(new_score: int):
	$Label.text = "Score: " + str(new_score)

func update_lives(count: int) -> void:
	for i in _life_container.get_child_count():
		_life_container.get_child(i).visible = i < count
