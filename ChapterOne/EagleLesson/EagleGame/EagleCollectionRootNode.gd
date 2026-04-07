extends Node2D

signal canContinue

func _on_score_win() -> void:
	canContinue.emit()
