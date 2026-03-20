@icon ("res://player/states/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region /// Referencias de estado
@onready var idle : PlayerState = get_node("../Idle")
@onready var run : PlayerState = get_node("../Run")
@onready var jump : PlayerState = get_node("../Jump")
@onready var fall : PlayerState = get_node("../Fall")
@onready var crouch : PlayerState = get_node("../Crouch")
#endregion


#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	pass


#¿Qué pasa si salimos de este estado?
func exit() -> void:
	pass


#¿Qué pasa si se pulsa un input?
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	return next_state


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	return next_state
