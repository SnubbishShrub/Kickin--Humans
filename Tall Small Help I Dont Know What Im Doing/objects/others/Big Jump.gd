extends Node


signal bigJump

func bigJump():
	emit_signal("bigJump", 0.5)
