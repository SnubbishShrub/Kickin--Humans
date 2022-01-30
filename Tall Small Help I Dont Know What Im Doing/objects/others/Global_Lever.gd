extends Node

signal LeverChanged
signal ButtonState

func LeverChanged():
	emit_signal("LeverChanged")

func ButtonState():
	emit_signal("ButtonState")
