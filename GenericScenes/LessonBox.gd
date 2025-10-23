@abstract class_name lessonBox extends Control

signal NextSignal();
signal BackSignal();

func updateFromResource():
	pass;

func _on_back_pressed() -> void:
	emit_signal("BackSignal")
	print("Back signal sent")

func _on_listen_again_pressed() -> void:
	pass # Replace with function body.

func _on_next_pressed() -> void:
	emit_signal("NextSignal")
	print("Next signal sent")
