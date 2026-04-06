extends Node

const MAX_LIVES := 3

var score: int = 0
var lives: int = MAX_LIVES

func increment_score() -> void:
	score += 1

func reset_score() -> void:
	score = 0

func lose_life() -> void:
	lives -= 1

func restore_life() -> void:
	if lives < MAX_LIVES:
		lives += 1

func get_lives() -> int:
	return lives

func reset_lives() -> void:
	lives = MAX_LIVES
