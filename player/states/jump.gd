@icon ("res://player/states/state.svg")
class_name PlayerStateJump extends PlayerState

@export var jump_velocity : float = 450.0
var started_falling : bool = false


#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	#reproducir animacion
	started_falling = false
	player.velocity.y = -jump_velocity
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
	player.velocity.x = player.direction.x * player.move_speed

	if player.velocity.y >= 0:
		started_falling = true

	if started_falling:
		return fall

	return null
