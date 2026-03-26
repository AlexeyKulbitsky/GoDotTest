extends CanvasLayer

func update_score(new_score: int):
	$Label.text = "Score: " + str(new_score)
